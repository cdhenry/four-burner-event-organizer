class Attendee < ActiveRecord::Base
  #include Slugifiable::InstanceMethods
  #extend Slugifiable::ClassMethods

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true

  has_secure_password

  has_many :attendee_events
  has_many :events, :through => :attendee_events
  has_many :event_types, :through => :events
end
