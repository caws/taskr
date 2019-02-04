class Task < ApplicationRecord
  belongs_to :status
  validates_presence_of :title, :body, :status_id

  scope :search_scope, ->(search_term) {
    where('title LIKE ? or body like ?', "%#{search_term}%", "%#{search_term}%")
  }

  after_create :send_create_notification, :update_screen
  after_update :send_update_notification, :update_screen
  after_destroy :send_destroy_notification, :update_screen

  def self.search(search_term)
    if search_term.to_s.length.positive?
      search_scope(search_term)
    else
      all
    end
  end

  # private

  def send_notification(type, message, data)
    # Adding a guard clause so that notifications aren't
    # sent during test execution
    return false if Rails.env.test?

    ActionCable.server.broadcast 'websocket_channel', type: type.to_s,
                                                      message: message.to_s,
                                                      data: data
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
    send_notification('update_screen', status.id.to_s,
                      render_data('home/status', 'statuses', Status.all))
    send_notification('update_tasks', status.id.to_s,
                      render_data('tasks/table', 'tasks', Task.all))
  end

  def render_data(partial_name, key, data)
    ApplicationController.renderer.render(partial: partial_name,
                                          locals: { "#{key}": data }).gsub('http://example.org', '')
  end

end
