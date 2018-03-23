class Burner < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

  validates :name, presence: true

  has_many :event_burners
  has_many :events, through: :event_burners
  has_many :users, through: :events
end
