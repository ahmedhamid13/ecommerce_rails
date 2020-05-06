class ProductsController < ApplicationController
    before_action :authenticate_user!, :except => [:show, :index]

    def index
        @products = Product.all
    end

    def new
        @product = Product.new
    end

    def create
        # render plain: product_params.inspect
        @product = Product.new(product_params)
        @product.store_id = 1
        # @product.price = params[:product]
        # render plain: params[:product].inspect
        # @product.store_id = current_user.store.id
 
        @product.save
        redirect_to @product
    end

    def show
        @product = Product.find(params[:id])
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private
        def product_params
            params.require(:product).permit(:title, :description, :price, :quantity, :category_id, :brand_id)
        end
end
