class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true

  belongs_to :creator, class_name: 'User'
  has_many :user_events
  #has_many :event_event_types
  has_many :users, through: :user_events
  has_many :burners, through: :users
  #has_many :event_types, :through => :event_event_types
end
