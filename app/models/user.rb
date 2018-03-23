class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true

  has_secure_password

  has_many :burners
  has_many :events_created, foreign_key: :creator_id, class_name: "Event"
  has_many :user_events
  has_many :events, through: :user_events
  #has_many :event_types, through: :events
end
