class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :date, presence: true
  validates :duration, presence: true

  belongs_to :user
  has_many :event_burners
  has_many :burners, through: :event_burners
end
