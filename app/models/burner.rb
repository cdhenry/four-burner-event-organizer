class Burner < ActiveRecord::Base
  validates :name, presence: true

  has_many :event_burners
  has_many :events, through: :event_burners
  has_many :users, through: :events

  def slug
    name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find{ |instance| instance.slug == slug }
  end
end
