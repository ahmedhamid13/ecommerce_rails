class CreateListedItems < ActiveRecord::Migration[6.0]
  def change
    create_table :listed_items do |t|
      t.integer :quantity , default: 1
      t.references :cart, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.timestamps
    end
  end
end
