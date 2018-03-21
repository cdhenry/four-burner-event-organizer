class CreateAttendeeEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :attendee_events do |t|
      t.string :attendee_id
      t.string :event_id
    end
  end
end
