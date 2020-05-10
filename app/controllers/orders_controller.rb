class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.where(user_id: current_user.id).where.not(state: "inCart").order(created_at: :desc)
  end
    
  def edit
      @order = Order.find_by(id: params[:id], state: "inCart")
  end
    
  def update
    @order = Order.find_by(id: params[:id], state: "inCart")
    @orderprod = OrderProduct.where(order_id: @order.id)
      @orderprod.each do |ordprod|
          ordprod.update(state: "pending")
      end
      if @order.update(state: "pending")
        redirect_to orders_path, notice: 'in Order'
      else
        render :edit
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
