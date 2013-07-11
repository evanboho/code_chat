class MessagesController < ApplicationController

  def create
    Messages.new.add(params[:content])

    data = CodeRay.scan(params[:content], :ruby).div.gsub("\n", "")

    ESHQ.send(:channel => "messages/create", :data => data, :type => "message")
  end

  def reset
    Messages.new.reset
  end

end