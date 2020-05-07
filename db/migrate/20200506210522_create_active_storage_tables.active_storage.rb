# This migration comes from active_storage (originally 20170806125915)
class CreateActiveStorageTables < ActiveRecord::Migration[5.2]
  def change
    create_table :active_storage_blobs do |t|
      t.string   :key,        null: false
      t.string   :filename,   null: false
      t.string   :content_type
      t.text     :metadata
      t.bigint   :byte_size,  null: false
      t.string   :checksum,   null: false
      t.datetime :created_at, null: false

      t.index [ :key ], unique: true, length: {"key"=>191}
    end

    create_table :active_storage_attachments do |t|
      t.string     :name,     null: false
      t.references :record,   null: false, polymorphic: true, index: false
      t.references :blob,     null: false

      t.datetime :created_at, null: false

      # t.index [ :record_type, :record_id, :name, :blob_id ], name: "index_active_storage_attachments_uniqueness", unique: true, length: {"record_type"=>191}, length: {"record_id"=>191}, length: {"name"=>191}, length: {"blob_id"=>191} 
      t.string [ :record_type ], unique: true
      t.string [ :record_id ], unique: true
      t.string [ :name ], unique: true
      t.string [ :blob_id ], unique: true

      t.foreign_key :active_storage_blobs, column: :blob_id
    end
  end
end
