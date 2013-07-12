class MessagesController < ApplicationController

  def index
    @channel = params[:channel]
    @lang = params[:lang]
    @messages = Messages.new(@channel).messages
  end

  def create
    channel = params[:channel]
    lang = params[:lang]
    Messages.new(channel).add(params[:content])

    data = CodeRay.scan(params[:content], lang.to_sym).div.gsub("\n", "")

    ESHQ.send(:channel => "messages/create/#{channel}", :data => data, :type => "message")
  end

  def reset
    channel = params[:channel]
    Messages.new(channel).reset    
    ESHQ.send(:channel => "messages/create/#{channel}/reset", :data => "", :type => "reset")
  end

end