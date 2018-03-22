class EventType < ActiveRecord::Base
  validates :name, presence: true

  has_many :event_event_types
  has_many :events, through: :event_event_types
  has_many :users, through: :events

  def slug
    self.name.gsub(" ", "-").downcase
  end

  def find_by_slug(slug)
    self.all.find{ |instance| instance.slug == slug }
  end
end
