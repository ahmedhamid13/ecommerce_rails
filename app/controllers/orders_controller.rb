class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new()
    @order.state = "inCart"
    @order.user_id = 1 #current_user_id
    @product = Product.find(params[:id])
    @order.products << @product
  
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def showCart 
    @items = Array.new
    @total_payment = 0
    @products = Order.where(state: "inCart").collect(&:products).flatten
    @products.each do |product|
       @items.push(product)
       @total_payment += (product.price * product.quantity)
    end 
  end

  # def editCart 
  #   @orderprod = OrderProduct.find(params[:id])
  # end

  # def updateCart
  #   @orderprod = OrderProduct.find(params[:id])
  #   @orderprod.update(order_products_params)
    
  #   if (@orderprod.product).update(quantity: ordprod.product.quantity-ordprod.quantity)
  #     redirect_to @orderprod
  #   else
  #       render 'editCart'
  #   end
  # end


  def edit
    @orderprod = OrderProduct.where(order_id: @order.id, state: "inCart")
  end

  def update
    @order = Order.find(params[:id])
    @orderprod = OrderProduct.find(order_id: @order.id)

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
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
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
end
