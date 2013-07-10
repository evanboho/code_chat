class EventsController < ApplicationController
  include ActionController::Live

  def create
    response.headers["Content-Type"] = "text/javascript"
    data = Event.new(params[:event])

    Messages.new.add(data.content)

    $redis.publish('messages.create', data.to_json)
  end

  def events
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    redis.subscribe('messages.create') do |on|
      on.message do |event, data|
        code = CodeRay.scan(JSON.parse(data)['content'], :ruby).div.gsub("\n", "")
        ESHQ.send(:channel => "events/events", :data => data, :type => "message")
        # response.stream.write("data: #{code}\n\n")
      end
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    redis.quit
    response.stream.close
  end

end
