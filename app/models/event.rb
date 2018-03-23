class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :date_and_time, presence: true

  belongs_to :user
  has_many :event_burners
  has_many :burners, through: :event_burners
end
