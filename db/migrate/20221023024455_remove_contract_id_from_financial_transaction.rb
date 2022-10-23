class RemoveContractIdFromFinancialTransaction < ActiveRecord::Migration[7.0]
  def change
    remove_column :financial_transactions, :contract_id, :integer
  end
end
