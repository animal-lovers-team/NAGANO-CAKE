class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.integer :postal_code, null: false
      t.string :shipping_address, null: false
      t.string :name, null: false
      t.integer :postage, default: 800, null: false
      t.integer :total_price, null: false
      t.integer :payment_method, default: 0, null: false
      t.integer :order_status, default: 0, null: false

      t.timestamps
    end
  end
end
