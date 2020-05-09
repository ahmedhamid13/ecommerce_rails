class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def cart
    @orders = Order.where(user_id: current_user.id, state: "inCart")
  end

  def store_order
    @orders = Order.where(store_id: current_user.store.id, state: "pending")
  end

  def buyer_order
    @orders = Order.where(user_id: current_user.id).where.not(state: "inCart").order(created_at: :desc)
  end
  ## Add To Cart
  def addToCart
    @product = Product.find(params[:id])
    if @product.quantity == 0
      redirect_to products_path, alert: 'Cannot add it, no available items for your order'
    else
      @order = Order.find_by(user_id: current_user.id, state: "inCart", store_id: (@product.store).id )
      if @order.nil?
        @order =Order.new
        @order.user_id = current_user.id
        @order.store_id = (@product.store).id
        @order.state = "inCart"
        @order.save
      end

      if params[:quantity].nil?
        ordprd(@order.id, params[:id])
      else
        ordprd(@order.id, params[:id],params[:quantity].to_i)
      end
      redirect_to request.referrer, notice: 'Cart Changed successfully'
    end
  end
    
    def set
      @orders = Order.where(user_id: current_user, state: "inCart")
    end
    
    ## Put in Order
    def putorder
      @orders = Order.where(user_id: current_user, state: "inCart")
      @orders.each do |order|
        @orderprod = OrderProduct.where(order_id: order.id)
        @orderprod.each do |ordprod|
          (ordprod.product).update(quantity: ordprod.product.quantity-ordprod.quantity)
        end
        order.update(state: "pending")
      end
        redirect_to myorder_path, notice: 'in Order'
    end

    def approve
      @order = Order.find(params[:id])
      @order.update(state: "approved")
      redirect_to request.referrer, notice: 'Approved'
    end

    def cancel
      @order = Order.find(params[:id])
      @order.update(state: "cancelled")
      redirect_to request.referrer, notice: 'Canceled'
    end

  def destroy
      @orders = Order.where(user_id: current_user, state: "inCart")
      @orders.each do |order|
        @orderprod = OrderProduct.find_by(order_id: order.id)
        @orderprod.destroy
        order.destroy
      end
      redirect_to request.referrer, notice: 'Deleted successfully'
  end

  def remove
      @orderprod = OrderProduct.find(params[:id])
      orderid = @orderprod.order_id
      @orderprod.destroy
      if OrderProduct.where(order_id: orderid).empty?
        Order.find_by(id: orderid, state: "inCart").destroy
      end
      redirect_to request.referrer, notice: 'Removed successfully'
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
      elsif @orderprod.quantity > 0
        unless @orderprod.quantity == 1 && quantity == -1
          @orderprod.update(quantity: @orderprod.quantity+quantity)
          @product.update(quantity: @product.quantity-quantity)
        end
      end
    end

end
