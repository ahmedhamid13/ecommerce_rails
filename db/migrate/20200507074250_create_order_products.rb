class CreateOrderProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :order_products do |t|
      t.integer :quantity
      t.string :state
      t.references :order
      t.references :product
      t.string :store_id

      t.timestamps
    end
  end
end
