class Event < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  validates :name, presence: true
  validates :description, presence: true

  belongs_to :creator, class_name: 'Attendee'
  has_many :attendee_events
  has_many :event_event_types
  has_many :attendees, :through => :attendee_events
  has_many :event_types, :through => :events_event_types


end
