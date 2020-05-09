class CreateOrderProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :order_products do |t|
      t.integer :quantity
      t.references :order
      t.references :product

      t.timestamps
    end
  end
end
