class AddStatusToContract < ActiveRecord::Migration[7.0]
  def change
    add_column :contracts, :status, :string, :default => "open"
  end
end
