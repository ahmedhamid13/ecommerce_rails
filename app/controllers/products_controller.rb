class ProductsController < ApplicationController
    def index
        @products = Product.all
    end

    def new
    end

    def create
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
            params.require(:product).permit(:title, :description, :price, :quantity)
        end
end
