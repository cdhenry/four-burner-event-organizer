class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.string :name
      t.string :description
      t.string :date
      t.string :start_time
      t.string :end_time
    end
  end
end
