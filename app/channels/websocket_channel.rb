class WebsocketChannel < ApplicationCable::Channel
  def subscribed
    stream_from "websocket_channel"
  end

  def unsubscribed
  end

end