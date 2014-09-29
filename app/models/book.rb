class Book < ActiveRecord::Base
  belongs_to :collection
  has_many :chapters
  validates :collection_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
end
