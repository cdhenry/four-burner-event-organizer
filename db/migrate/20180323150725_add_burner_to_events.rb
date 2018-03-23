class AddBurnerToEvents < ActiveRecord::Migration[5.1]
  def change
    add_reference :events, :burner, index: true
  end
end
