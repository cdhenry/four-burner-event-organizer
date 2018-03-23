class CreateBurners < ActiveRecord::Migration[5.1]
  def change
    create_table :burners do |t|
      t.string :name
    end
  end
end
