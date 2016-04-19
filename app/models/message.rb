class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  after_create_commit :perform

  def perform
    ActionCable.server.broadcast 'room_channel', message: self, username: self.user.username
    #ActionCable.server.broadcast 'room_channel', message: render_message
  end

  private
    def render_message
      ApplicationController.renderer.render(partial: 'messages/message', locals: { message: self })
    end
end
