class HomeController < ApplicationController
  include ActionController::Live

  def index
    channel = Messages.new.channel
    redirect_to messages_path(lang: params[:lang] || "ruby", channel: channel)
  end

end
