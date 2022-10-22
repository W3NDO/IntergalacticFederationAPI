class AddNameToShipModel < ActiveRecord::Migration[7.0]
  def change
    add_column :ships, :name, :string
  end
end
