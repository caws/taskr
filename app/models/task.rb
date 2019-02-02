class Task < ApplicationRecord
  belongs_to :status
  validates_presence_of :title, :body, :status_id

end
