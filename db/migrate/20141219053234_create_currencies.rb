class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :shortname
      t.string :longname

      t.timestamps
    end
  end
end
