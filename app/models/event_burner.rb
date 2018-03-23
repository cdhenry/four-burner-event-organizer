class EventBurner < ActiveRecord::Base
  belongs_to :event
  belongs_to :burner
end
