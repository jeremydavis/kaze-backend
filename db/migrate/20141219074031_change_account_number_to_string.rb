class ChangeAccountNumberToString < ActiveRecord::Migration
  def change
    change_column :payees, :account_number, :string
  end
end
