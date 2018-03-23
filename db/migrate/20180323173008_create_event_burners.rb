class CreateEventBurners < ActiveRecord::Migration[5.1]
  def change
    create_table :event_burners do |t|
      t.belongs_to :event
      t.belongs_to :burner
    end
  end
end
