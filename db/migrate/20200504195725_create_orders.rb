class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user
      t.references :store
      t.string :state
      
      t.timestamps
    end
  end
end
