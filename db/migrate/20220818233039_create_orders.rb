class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :buying_group, null: false, foreign_key: true

      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :zip_code, null: false
      t.string :state, null: false
      t.string :city, null: false
      t.string :address, null: false
      t.string :address_number, null: false
      t.integer :status, default: 0
      t.string :address_complement
      t.string :observation


      t.timestamps
    end
  end
end
