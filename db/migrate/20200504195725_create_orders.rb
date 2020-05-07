class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :state
      # t.integer :quantity
      t.references :user

      t.timestamps
    end
  end
end
