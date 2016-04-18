class Message < ApplicationRecord
  after_create_commit :perform

  def perform
    ActionCable.server.broadcast 'room_channel', message: self
    #ActionCable.server.broadcast 'room_channel', message: render_message
  end

  private
    def render_message
      ApplicationController.renderer.render(partial: 'messages/message', locals: { message: self })
    end
end
