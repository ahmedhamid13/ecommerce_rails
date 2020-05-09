class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def cart
    @order = Order.find_by(user_id: current_user.id, state: "inCart")
  end

  def order
    @orders = Order.where(user_id: current_user.id).where.not(state: "inCart").order(created_at: :desc)
  end

  ## Add To Cart
  def addToCart
    if Product.find(params[:id]).quantity == 0
    # if params[:quantity].to_i > 0
      redirect_to products_path, alert: 'Cannot add it, no available items for your order'
    else
      @order = Order.find_by(user_id: current_user.id, state: "inCart")
      if @order.nil?
        @order =Order.new
        @order.user_id = current_user.id
        @order.state = "inCart"
        @order.save
      end
      if params[:quantity].nil?
        ordprd(@order.id, params[:id])
      else
        ordprd(@order.id, params[:id],params[:quantity].to_i)
      end
      redirect_to mycart_path, notice: 'added to cart successfully'
    end
  end
    
    def edit
      @order = Order.find(params[:id])
    end
    
    ## Put in Order
    def update
    @order = Order.find(params[:id])
    @orderprod = OrderProduct.where(order_id: @order.id)

    @orderprod.each do |ordprod|
      (ordprod.product).update(quantity: ordprod.product.quantity-ordprod.quantity)
    end

    if @order.update(state: "pending")
      redirect_to :action => 'order'
    else
        render 'edit'
    end
  end

  def destroy
    if @order.state == "inCart"
      @orderprod = OrderProduct.find_by(order_id: @order.id)
      @orderprod.destroy
      @order.destroy
      redirect_to mycart_path, notice: 'Removed successfully'
    else
      redirect_to orders_url, notice: 'Order didnt destroy.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.fetch(:order, {}).permit(:id,:quantity)
    end

    def ordprd (ord_id, prd_id, quantity = 1)
      @orderprod = OrderProduct.find_by(order_id: ord_id, product_id: prd_id)
      @order = Order.find(ord_id)
      @product = Product.find(prd_id)
      if @orderprod.nil?
        @order.products << @product
        OrderProduct.find_by(order_id: ord_id, product_id: prd_id).update(quantity: quantity)
      else
        @orderprod.update(quantity: @orderprod.quantity+quantity)
      end
      @product.update(quantity: @product.quantity-quantity)
    end
end
