class Task < ApplicationRecord
  belongs_to :status
  validates_presence_of :title, :body, :status_id

  scope :search_scope, ->(search_term) {where("title LIKE ? or body like ?", "%#{search_term}%", "%#{search_term}%")}

  after_create :send_create_notification
  after_update :send_update_notification
  after_destroy :send_destroy_notification

  def self.search search_term
    if search_term.to_s.length > 0
      search_scope(search_term)
    else
      all
    end
  end

  private

  def send_notification type, message
    ActionCable.server.broadcast 'websocket_channel', type: "#{type}", message: "#{message}"
  end

  def send_create_notification
    send_notification('notification', "Task '#{title}' was created.")
  end

  def send_destroy_notification
    send_notification('notification', "Task '#{title}' was destroyed.")
  end

  def send_update_notification
    send_notification('notification', "Task '#{title}' was updated.")
  end

end
