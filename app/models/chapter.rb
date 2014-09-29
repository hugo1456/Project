class Chapter < ActiveRecord::Base
  belongs_to :book
  validates :book_id, presence: true
  validates :name, presence: true
  validates :content, presence: true
  
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
end
