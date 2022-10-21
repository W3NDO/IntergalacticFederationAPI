class AddCreditsColumnToPilots < ActiveRecord::Migration[7.0]
  def change
    add_column :pilots, :credits, :integer
  end
end
