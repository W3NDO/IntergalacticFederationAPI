class ChangePilotsCreditsFieldToMoneyType < ActiveRecord::Migration[7.0]
  def change
    remove_column :pilots, :credits, :integer
    add_monetize :pilots, :credits
  end
end
