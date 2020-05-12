class CreateOrderProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :order_products do |t|
      t.integer :quantity, :default => 0
      t.string :state, :default => "inCart"
      t.references :order
      t.references :product
      t.string :store_id

      t.timestamps
    end
  end
end
