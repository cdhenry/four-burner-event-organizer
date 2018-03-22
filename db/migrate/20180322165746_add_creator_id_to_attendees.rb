class AddCreatorIdToAttendees < ActiveRecord::Migration[5.1]
  def change
    add_column :attendees, :creator_id, :integer
  end
end
