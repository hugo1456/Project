class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships,	foreign_key: "followed_id",
					class_name: "Relationship",
					dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  has_many :books, through: :collections
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:login]
  attr_accessor :login
  validates :username, :uniqueness => {:case_sensitive => false }, presence: true

  extend FriendlyId
  friendly_id :username, use: :slugged

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def feed
    Post.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def self.search(search)
    query = "%#{search}%"
    Rails.env.development? ? where('username LIKE :search OR first_name LIKE :search OR last_name LIKE :search', search: query) : where('username ILIKE :search OR first_name ILIKE :search OR last_name ILIKE :search', search: query )
  end
end
