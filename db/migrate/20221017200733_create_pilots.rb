class CreatePilots < ActiveRecord::Migration[7.0]
  def change
    create_table :pilots do |t|
      t.integer :certification
      t.string :name
      t.integer :age
      t.string :location_planet

      t.timestamps
    end
  end
end
