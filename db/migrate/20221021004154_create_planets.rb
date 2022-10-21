class CreatePlanets < ActiveRecord::Migration[7.0]
  def change
    create_table :planets do |t|
      t.string :name
      t.integer :resources_received
      t.integer :resources_sent

      t.timestamps
    end
  end
end
