class CreatePayees < ActiveRecord::Migration
  def change
    create_table :payees do |t|
      t.string :nickname
      t.string :account_holder
      t.integer :account_number
      t.string :bank_name
      t.string :branch_name

      t.timestamps
    end
  end
end
