class Attendee < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  has_many :attendee_events
  has_many :events, :through => :attendee_events
  has_many :event_types, :through => :events
end
