class CreateEventEventTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :event_event_types do |t|
      t.belongs_to :event, index: true
      t.belongs_to :event_type, index: true
    end
  end
end
