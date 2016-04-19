class MessagesController < ApplicationController
  def index
    @messages = Room.find(params[:room_id]).messages.includes(:user)
      .joins("JOIN users AS user ON user.id = messages.user_id")
      .select("messages.*, user.username AS username")

    respond_to do |format|
      format.html
      format.json { render json: @messages }
    end
  end

  def create
    sanitized_message = ActionController::Base.helpers.sanitize(params[:message][:content])
    @message = Message.new content: params['message']['content'], room_id: params['message']['room_id']
    @message.user_id  = current_user.id if current_user
    if @message.save
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end
end
