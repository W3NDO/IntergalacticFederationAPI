class RenameTypeToTransactionTypeInTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_column :financial_transactions, :type, :string
    remove_column :financial_transactions, :origin_planet, :string
    remove_column :financial_transactions, :destination_planet, :string
    
    add_column :financial_transactions, :transaction_type, :string
    add_column :financial_transactions, :transaction_origin_planet, :string
    add_column :financial_transactions, :transaction_destination_planet, :string
  end
end
