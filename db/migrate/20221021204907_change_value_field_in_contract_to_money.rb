class ChangeValueFieldInContractToMoney < ActiveRecord::Migration[7.0]
  def change
    add_monetize :contracts, :value
    remove_column :contracts, :value, :integer

  end
end
