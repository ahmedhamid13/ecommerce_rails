class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.integer :quantity
      t.integer :rate
      t.integer :reviewers
      t.references :category
      t.references :brand
      t.references :store

      t.timestamps
    end
  end
end
