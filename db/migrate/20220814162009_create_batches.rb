class CreateBatches < ActiveRecord::Migration[7.0]
  def change
    create_table :batches do |t|
      t.references :buying_group, null: false, foreign_key: true

      t.string :description, null: false
      t.decimal :amount, null: false, precision: 14, scale: 2
      t.integer :quantity, null: false
      t.integer :width, null: false
      t.integer :height, null: false
      t.integer :length, null: false
      t.integer :weight, null: false

      t.timestamps
    end
  end
end
