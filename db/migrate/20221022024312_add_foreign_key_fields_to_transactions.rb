class AddForeignKeyFieldsToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :financial_transactions, :pilot_id, :integer
    add_column :financial_transactions, :ship_id, :integer
    add_column :financial_transactions, :origin_planet_id, :integer
    add_column :financial_transactions, :destination_planet_id, :integer
  end
end
