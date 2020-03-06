class User < ActiveRecord::Base
  has_secure_password
  has_many :listings
  validates :username, uniqueness: true, presence: true
  validates :password, length: { in: 6..20 }
end
