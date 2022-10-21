class CreateContracts < ActiveRecord::Migration[7.0]
  def change
    create_table :contracts do |t|
      t.text :description
      t.string :payload
      t.string :origin_planet
      t.string :destination_planet
      t.integer :value

      t.timestamps
    end
  end
end
