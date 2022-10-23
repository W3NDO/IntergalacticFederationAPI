class AddContractIdToResources < ActiveRecord::Migration[7.0]
  def change
    add_column :resources, :contract_id, :integer
  end
end
