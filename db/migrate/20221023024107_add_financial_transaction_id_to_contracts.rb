class AddFinancialTransactionIdToContracts < ActiveRecord::Migration[7.0]
  def change
    add_column :contracts, :financial_transaction_id, :integer
  end
end
