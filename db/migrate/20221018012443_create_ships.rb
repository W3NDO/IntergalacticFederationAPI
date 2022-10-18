class CreateShips < ActiveRecord::Migration[7.0]
  def change
    create_table :ships do |t|
      t.integer :fuel_capacity
      t.integer :fuel_level
      t.integer :weight_capacity

      t.timestamps
    end
  end
end
