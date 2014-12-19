class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer :account_id
      t.integer :payee_id
      t.integer :currency_id
      t.decimal :value
      t.text :description
      t.date :transfer_date
      t.boolean :repeat
      t.date :repeat_until
      t.string :status
      t.datetime :submitted_at
      t.boolean :transaction_password_valid
      t.boolean :otp_password_valid

      t.timestamps
    end
  end
end
