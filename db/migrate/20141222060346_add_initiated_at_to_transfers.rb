class AddInitiatedAtToTransfers < ActiveRecord::Migration
  def change
    add_column :transfers, :initiated_at, :datetime
  end
end
