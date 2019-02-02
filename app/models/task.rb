class Task < ApplicationRecord
  belongs_to :status
  validates_presence_of :title, :body, :status_id

  scope :search_scope, ->(search_term) {where("title LIKE ? or body like ?", "%#{search_term}%", "%#{search_term}%")}

  after_create :send_create_notification, :update_screen
  after_update :send_update_notification, :update_screen
  after_destroy :send_destroy_notification, :update_screen

  def self.search search_term
    if search_term.to_s.length > 0
      search_scope(search_term)
    else
      all
    end
  end

  private

  def send_notification type, message, data
    ActionCable.server.broadcast 'websocket_channel', type: "#{type}", message: "#{message}", data: data
  end

  def send_create_notification
    send_notification('notification', "Task '#{title}' was created.", nil)
  end

  def send_destroy_notification
    send_notification('notification', "Task '#{title}' was destroyed.",nil)
  end

  def send_update_notification
    send_notification('notification', "Task '#{title}' was updated.", nil)
  end

  def update_screen
    send_notification('update_screen', "#{self.status.id}", render_data(Status.all))
  end

  def render_data(data)
    ApplicationController.renderer.render(partial: 'home/status', locals: { statuses: data })
  end

end
