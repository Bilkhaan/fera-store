class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :order_id, null: false
      t.string :order_number
      t.string :ordered_by
      t.belongs_to :shop, index: true

      t.timestamps
    end

    add_index :orders, :order_id, unique: true
  end
end
