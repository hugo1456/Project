class Collection < ActiveRecord::Base
  belongs_to :user
  has_many :books
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { maximum: 500 }
  
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
end
