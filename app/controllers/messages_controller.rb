class MessagesController < ApplicationController
  before_action :require_login

  def index
    if params[:unread]
      @messages = current_user.unread_messages
      @unread = true
    elsif params[:sent]
      @sent = true
      @messages = current_user.sent_messages
    end
  end

  def show
    @message = Message.find_by_id(params[:id])
    @message.read_at = Time.now
    @message.save
  end

  def new
    @message = Message.new
    @friends = current_user.friends
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      flash[:success] = "Message sent!"
      redirect_to root_path
    else
      flash.now[:error] = @message.errors.full_messages.to_sentence
      render 'new'
    end
  end

  private
    def message_params
      params.require(:message).permit(:subject, :body, :sender_id, :recipient_id)
    end
end
