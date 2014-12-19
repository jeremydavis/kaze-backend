class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :account_number
      t.integer :currency_id
      t.decimal :balance

      t.timestamps
    end
  end
end
