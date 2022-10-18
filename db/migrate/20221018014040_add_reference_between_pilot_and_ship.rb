class AddReferenceBetweenPilotAndShip < ActiveRecord::Migration[7.0]
  def change
    add_reference :ships, :pilots
  end
end
