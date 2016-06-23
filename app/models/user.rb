class User < ActiveRecord::Base
  has_many :secrets
  has_many :likes, dependent: :destroy
  has_many :secrets_liked, through: :likes, source: :secret
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, :email, presence: true
  validates :password, :password_confirmation, presence: true, on: :create
  validates :email, uniqueness: {case_sensitive: false}, format: {with: EMAIL_REGEX}

  before_save do
  	self.email.downcase!  	
  end

  # def already_likes?(secret)
  # 	self.likes.find(secret: secret.id)
  # end
end
