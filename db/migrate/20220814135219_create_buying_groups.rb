class CreateBuyingGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :buying_groups do |t|
      t.string :name, null: false
      t.date :date, null: false
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
