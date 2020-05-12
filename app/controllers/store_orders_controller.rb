class StoreOrdersController < ApplicationController
  before_action :authenticate_user!
  
    def index
      if !(current_user.store).nil?
        @store_orders = OrderProduct.where(store_id: current_user.store.id)
        @orders = @store_orders.where(state: "pending").or(@store_orders.where(state: "confirmed")).page params[:page]
      else
        redirect_to orders_path, alert: 'you do not have store!'
      end
    end
  
    def history
      if !(current_user.store).nil?
        @store_orders = OrderProduct.where(store_id: current_user.store.id)
        @orders = @store_orders.where(state: "delivered").order(created_at: :desc).page params[:page]
      else
        redirect_to orders_path, alert: 'you do not have store!'
      end
    end

    def update
        @order = OrderProduct.find(params[:id])
        if @order.state == "pending" || @order.state == "confirmed"
          if @order.order.state == "pending"
            update_orders("confirmed")
            redirect_to request.referrer
          end
          if @order.order.state == "confirmed"
            update_orders("delivered")
            redirect_to request.referrer
          end
        end
    end

    private

    def store_orders_params
        params.permit(:id, :state, :page)
    end

    def update_orders(stat)
      @order.update(state: stat)
      @orders = OrderProduct.where(order_id: @order.order_id)
      if @orders.where(state: @order.order.state).empty?
        Order.find(@order.order_id).update(state: stat)
        if stat == "delivered"
          Address.find_by(order_id: @order.order_id).destroy
        end
      end
    end
  
end
