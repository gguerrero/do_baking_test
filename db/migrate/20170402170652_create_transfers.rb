class CreateTransfers < ActiveRecord::Migration[5.0]
  def change
    create_table :transfers do |t|
      t.datetime :completed_at
      t.integer :status_code
      t.string :status_message
      t.integer :account_from_id
      t.integer :account_to_id
      t.integer :quantity
      t.integer :commission

      t.timestamps
    end
  end
end
