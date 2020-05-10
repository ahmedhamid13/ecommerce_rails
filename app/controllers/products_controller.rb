class ProductsController < ApplicationController
    # load_and_authorize_resource
    before_action :authenticate_user!, :except => [:show, :index]
    before_action :filter_parameters

    def index
        if(params[:filterby])
            @products = Product.filter(params[:filterValue], params[:filterby])
        else
            @products = Product.search(params[:search])
        end
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)
        @product.store_id = current_user.store.id
        @product.reviewers = 0
        @product.rate = 0
 
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

    def rate
        @product = Product.find(params[:id])

        @product.update(reviewers: (@product.reviewers+1) )
        @product.update(rate: ((@product.rate + params[:rate].to_i)/2))

        redirect_to @product
    end

    def destroy
        @product = Product.find(params[:id])
        @product.destroy

        redirect_to products_path
    end

    def filter_parameters
        @categories = Category.all
        @brands = Brand.all
        @stores = Store.all
    end

    def filter_products
        if params[:categories].present? || params[:brands].present? || params[:stores].present?
            if params[:categories].present?
                @products = (@products.nil?) ? Product.where(category_id: params[:categories]) : @products.where(category_id: params[:categories])
            end

            if params[:brands].present?
                puts "brands = #{@brands}"
                @products = (@products.nil?) ? Product.where(brand_id: params[:brands]) : @products.where(brand_id: params[:brands])
            end   

            if params[:stores].present?
                @products = (@products.nil?) ? Product.where(store_id: params[:stores]) : @products.where(store_id: params[:stores])
            end

        else
            @products = Product.all
        end
        respond_to do |format|
            format.js
        end
    end

    private
        def product_params
            params.require(:product).permit(:title, :rate, :description, :price, :quantity, :category_id, :brand_id, :image)
        end
end
