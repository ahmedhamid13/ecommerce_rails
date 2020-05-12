class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  def index
    @orders = Order.where(user_id: current_user.id).where.not(state: "inCart").order(created_at: :desc)
  end
    
  def edit
      @order = Order.find_by(id: params[:id], state: "inCart")
  end
    
  def update
    @order = Order.find_by(id: params[:id], state: "inCart")
    @orderprod = OrderProduct.where(order_id: @order.id)
    if check_quantity()
      if !order_address()
        @orderprod.each do |ordprod|
              ordprod.update(state: "pending")
              (ordprod.product).update(quantity: ordprod.product.quantity-ordprod.quantity)
        end
        if @order.update(state: "pending")
          redirect_to orders_path, notice: 'put in Order'
        end
      else
        redirect_to request.referrer, alert: 'Form inputs not valid please check them'
      end
    else
      redirect_to carts_path, alert: 'Quantity of order didnot match available products'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.fetch(:order, {}).permit(:id,:quantity,:address, :billing)
    end

    def order_address
      Address.create(address: params[:address], billing: params[:billing], user_id: current_user.id, order_id: @order.id)
      Address.where(address: params[:address], billing: params[:billing], user_id: current_user.id, order_id: @order.id).empty?
    end

    def check_quantity
      @orderprod.each do |ordprod|
        if ordprod.product.quantity < ordprod.quantity
          return false
        end
      end
      return true
    end

end
