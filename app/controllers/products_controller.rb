class ProductsController < ApplicationController
    # load_and_authorize_resource
    before_action :authenticate_user!, :except => [:show, :index]

    def index
        if(params[:filter])
            @products = Product.filter(params[:filter], params[:filterby])
        else
            @products = Product.search(params[:search])
        end
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)
        @product.store_id = 1
        # @store = Store.find_by(user_id: current_user.id)
        # @product.store_id = @store.id
 
        if @product.save
            redirect_to @product
        else
            render 'new'
        end
    end

    def show
        @product = Product.find(params[:id])
    end

    def edit
        @product = Product.find(params[:id])
    end

    def update
        @product = Product.find(params[:id])
 
        if @product.update(product_params)
            redirect_to @product
        else
            render 'edit'
        end
    end

    def destroy
        @product = Product.find(params[:id])
        @product.destroy

        redirect_to products_path
    end

    private
        def product_params
            params.require(:product).permit(:title, :description, :price, :quantity, :category_id, :brand_id, :image)
        end
end
