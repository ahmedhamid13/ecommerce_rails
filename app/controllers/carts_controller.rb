class CartsController < ApplicationController
  
  def index
    # @carts = Cart.all
      @items = Array.new
      @total_payment = 0
      @products = Order.where(state: "inCart").collect(&:products).flatten
      @products.each do |product|
         @items.push(product)
         @total_payment += (product.price * product.quantity)
      end 
  end

  def show
    @cart = Cart.find(params[:id])
  end

  def new
    @cart = Cart.new
  end

  def create
    @cart = Cart.new()
    @cart.quantity = 2
    @cart.user_id = current_user.id
    @cart.product_id = params[:id]
    if @cart.save
      redirect_to @cart
    else
      render :new
    end
  end
  def newAddToCart
  end
  def addToCart
    redirect_to products_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def cart_params
      params.require(:product).permit(:id, :quantity, :price, :quantity, :product_id, :user_id)
  end
end
