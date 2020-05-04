class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :source
      t.references :product

      t.timestamps
    end
  end
end
