class EventType < ActiveRecord::Base  
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  has_many :event_event_types
  has_many :events, :through => :events_event_types
  has_many :attendees, :through => :events
end
