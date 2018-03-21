class CreateEventEventTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :event_event_types do |t|
      t.string :event_id
      t.string :event_type_id
    end
  end
end
