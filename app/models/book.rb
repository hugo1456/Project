class Book < ActiveRecord::Base
  belongs_to :collection
  validates :collection_id, presence: true
  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { maximum: 500 }
  
end
