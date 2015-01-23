class ConvertTransferValueFromDecimelToStringBecauseOfRoundingSillyness < ActiveRecord::Migration
  def change
    change_column :transfers, :value, :string
  end
end
