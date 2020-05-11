class ProductsController < ApplicationController
    # load_and_authorize_resource
    before_action :authenticate_user!, :except => [:show, :index]
    before_action :filter_parameters
    # self.page_cache_directory = :domain_cache_directory
    # caches_page :show

    def index
        @searched_item = params[:search]
        @products = Product.search(params[:search])
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)
        @product.store_id = current_user.store.id

        if @product.save
            redirect_to @product
        else
            render 'new'
        end
    end

    def show
        @product = Product.find(params[:id])
        @rate = Rate.new
        @reviews = Review.where(product_id: params[:id])
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

    def filter_parameters
        @categories = Category.all
        @brands = Brand.all
        @stores = Store.all
    end

    def filter_products

        unless @searched_item.nil? || @searched_item.empty?
            @products = Product.search(@searched_item)
        end

        if params[:categories].present? || params[:brands].present? || params[:stores].present? || params[:price_min].present? || params[:price_max].present?

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

            if params[:price_min].present?
                @products = (@products.nil?) ? Product.where("price >= ?", params[:price_min]) : @products.where("price >= ?", params[:price_min])
            end

            if params[:price_max].present?
                @products = (@products.nil?) ? Product.where("price <= ?", params[:price_max]) : @products.where("price <= ?", params[:price_max])
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

        def domain_cache_directory
            Rails.root.join("public", request.domain)
        end
end
