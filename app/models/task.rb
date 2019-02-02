class Task < ApplicationRecord
  belongs_to :status
  validates_presence_of :title, :body, :status_id

  scope :search_scope, ->(search_term) {where("title LIKE ? or body like ?", "%#{search_term}%", "%#{search_term}%")}

  def self.search search_term
    if search_term.to_s.length > 0
      search_scope(search_term)
    else
      all
    end
  end
end
