class CreateTransferTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :transfer_types do |t|
      t.string :name
      t.integer :commission
      t.integer :max_per_transfer

      t.timestamps
    end
  end
end
