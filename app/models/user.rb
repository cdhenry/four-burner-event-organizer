class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true

  has_secure_password

  has_many :events
  has_many :burners, through: :events
end
