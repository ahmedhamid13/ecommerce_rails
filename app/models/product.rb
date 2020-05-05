class Product < ApplicationRecord
    belongs_to :category
    belongs_to :brand
    belongs_to :store
    has_many :images
    has_and_belongs_to_many :orders
end
