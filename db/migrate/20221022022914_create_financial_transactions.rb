class CreateFinancialTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :financial_transactions do |t|
      t.text :description
      t.string :type
      t.string :transaction_hash
      t.integer :amount
      t.string :origin_planet
      t.string :destination_planet
      t.string :ship_name
      t.string :pilot_certification

      t.timestamps
    end
  end
end
