class ChangeResourcesSentandReceivedToJsonb < ActiveRecord::Migration[7.0]
  def change
    remove_column :planets, :resources_sent, :integer
    add_column :planets, :resources_sent, :jsonb
    
    remove_column :planets, :resources_received, :integer
    add_column :planets, :resources_received, :jsonb
  end
end
