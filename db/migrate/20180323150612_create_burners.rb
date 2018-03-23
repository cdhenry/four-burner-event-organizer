class CreateBurners < ActiveRecord::Migration[5.1]
  def change
    create_table :burners do |t|
      t.string :name
      t.belongs_to :user
    end
  end
end
