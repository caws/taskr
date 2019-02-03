class Status < ApplicationRecord
  has_many :tasks
  validates_presence_of :description
end
