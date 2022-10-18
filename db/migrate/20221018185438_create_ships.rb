class CreateShips < ActiveRecord::Migration[7.0]
  def change
    create_table :ships do |t|
      t.integer :weight_capacity
      t.integer :fuel_capacity
      t.integer :fuel_level
      t.integer :pilot_id

      t.timestamps
    end
  end
end
