class Product < ApplicationRecord
    belongs_to :category
    belongs_to :brand
    belongs_to :store
    has_one_attached :image
    has_many :rates
    has_many :reviews
    has_many :order_products
    has_many :orders, through: :order_products

    validates :title, presence: true, length: { minimum: 5 }

    validates :price, :quantity, numericality: true

    validates :description, :price, :quantity, :category_id, :brand_id, presence: true
    
    def self.search(search)
        if search
            products = self.where("lower(title) LIKE lower(?) or lower(description) LIKE(?)", "%#{search}%", "%#{search}%")

            if products.exists?
                products
            else
                @products = []
            end
        else
            @products = self.all
        end
    end

    def check_order(prod, id)
        @orders = Order.where(user_id: id, state: "delivered")
        if !@orders.empty?
            @orders.each do |order|
                if !(order.order_products).where(product_id: prod.id).empty?
                    return true
                end
            end
        end
        return false
    end

    self.per_page = 10

end

WillPaginate.per_page =10