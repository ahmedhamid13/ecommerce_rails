class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.where(user_id: current_user.id, state: "inCart")
  end

  def show
    @order = Order.find(params[:id])
    @orderprod = OrderProduct.find_by(order_id: @order.id)
  end

  # def new
  #   @order = Order.where(user_id: current_user.id, state: "inCart")
  #   if @order.empty?
  #     @order =Order.new
  #   end
  # end

  def create
    @order = Order.find_by(user_id: current_user.id, state: "inCart")
    if @order.nil?
      @order =Order.new
      @order.user_id = current_user.id
      @order.state = "inCart"
      @order.save
    end

    ordprd(@order.id, params[:id])
    
    redirect_to @order, notice: 'Order was successfully created.'    
      # if 
      # else
      #   render :new
      # end
  end

  def edit
    @orderprod = OrderProduct.where(order_id: @order.id, state: "inCart")
  end

  def update
    @order = Order.find(params[:id])
    @orderprod = OrderProduct.where(order_id: @order.id)

    @orderprod.each do |ordprod|
      (ordprod.product).update(quantity: ordprod.product.quantity-ordprod.quantity)
    end

    if @order.update(state: "pending")
        redirect_to @order
    else
        render 'edit'
    end
  end

  def destroy
    if @order.state == "inCart"
      @order.destroy
        redirect_to orders_url, notice: 'Order was successfully destroyed.'
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

    def ordprd (ord_id, prd_id)
      @orderprod = OrderProduct.find_by(order_id: ord_id, product_id: prd_id)
      if @orderprod.nil?
        @product = Product.find(prd_id)
        @order.products << @product
        @order.order_products.update(quantity: 1)
      else
        @orderprod.update(quantity: 2)
      end
    end
end
