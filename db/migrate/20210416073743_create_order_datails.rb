class CreateOrderDatails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_datails do |t|
      t.integer :product_id, null: false
      t.integer :order_id, null: false
      t.integer :subprice, null: false
      t.integer :quantity, null: false
      t.integer :production_status,default: 0

      t.timestamps
    end
  end
end
