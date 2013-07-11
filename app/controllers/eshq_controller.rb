class EshqController < ApplicationController

  def socket
    socket = ESHQ.open(:channel => params[:channel])
    render :json => {:socket => socket}.to_json
  end

end
