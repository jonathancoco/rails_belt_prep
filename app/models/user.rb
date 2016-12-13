class User < ActiveRecord::Base
  has_secure_password
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :first_name, :last_name, :email, :location, :state, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, length: { minimum: 8 }, allow_nil: true

  has_many :events, :dependent => :delete_all
  has_many :comments, :dependent => :delete_all
  has_many :attendings, :dependent => :delete_all
end
