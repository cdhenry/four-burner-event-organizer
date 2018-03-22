class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.belongs_to :creator
      t.string :name
      t.string :description
    end
  end
end
