class CartsController < ApplicationController
  
  def index
      @cart = Cart.all
      @items = Array.new
      @total_payment = 0
      @products = Cart.where(user_id: current_user.id).collect(&:products).flatten
      @products.each do |product|
         @items.push(product)
         @quantity = ListedItem.find_by(cart_id: product.cart_ids[0]).quantity
         @total_payment += (product.price * @quantity)
      end 
  end

  def show
    @cart = Cart.find(params[:id])
  end

  def new
    @cart = Cart.new
  end

  def create
  end
  def newAddToCart
  end
  def addToCart
    @comming_quantity = cart_params[:quantity].to_i
    puts params[:id]
    @cart = Cart.where(user_id: current_user.id).first
    unless(@cart)
      @cart = Cart.new
      @cart.user_id = current_user.id
    end
    if @cart.product_ids.include?(params[:id].to_i)
      @old_quantity = ListedItem.find_by(product_id: params[:id]).quantity
      @new_quantity = @old_quantity + @comming_quantity
      ListedItem.find_by(product_id: params[:id]).update({quantity: @new_quantity  })
    else
      @product = Product.find(params[:id])
      @cart.products << @product
      ListedItem.find_by(product_id: params[:id]).update({quantity: @comming_quantity })
    end
    respond_to do |format|
      if @cart.save 
        format.html { redirect_to products_path, notice: 'item added to your cart' }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def cart_params
      params.permit(:id, :quantity, :price, :quantity, :product_id, :user_id)
  end
end
