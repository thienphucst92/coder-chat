class MessagesController < ApplicationController

  def index
    @messages = current_user.unread_messages
  end

  def show
    @message = Message.find_by_id(params[:id])
    @message.read_at = Time.now
    @message.save
  end
end
