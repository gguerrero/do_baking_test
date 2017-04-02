class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :holder
      t.references :bank, foreign_key: true
      t.integer :current_credit

      t.timestamps
    end
  end
end
