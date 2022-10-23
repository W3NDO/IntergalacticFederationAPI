class AddContractIdToFinancialTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :financial_transactions, :contract_id, :integer
  end
end
