class AddMoneyToFinancialTransactions < ActiveRecord::Migration[7.0]
  def change
    add_monetize :financial_transactions, :value
  end
end
