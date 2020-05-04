class CreateOrderProductsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :orders_products do |t|
      t.references :order
      t.references :product

      t.timestamps
    end
  end
end
