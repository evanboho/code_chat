class EshqController < ApplicationController

  def socket
    logger.info "+++ #{params[:channel]}"
    socket = ESHQ.open(:channel => params[:channel])
    render :json => {:socket => socket}.to_json
  end

end
