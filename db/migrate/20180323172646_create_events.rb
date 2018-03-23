class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.belongs_to :user
      t.string :name
      t.string :description
      t.datetime :date_and_time
    end
  end
end
