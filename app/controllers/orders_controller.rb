class OrdersController < ApplicationController
    before_action :authenticate_user!

    def index
        @orders = Order.search(params[:search])
    end

    def new
        @order = Order.new
    end

    def create
        @order = Order.new(order_params)
        @order.store_id = 1
        # @order.images.attach(params[:images])
        # @order.price = params[:order]
        # render plain: params[:order].inspect
        # @order.store_id = current_user.store.id
 
        if @order.save
            redirect_to @order
        else
            render 'new'
        end
    end

    def show
        @order = Order.find(params[:id])
    end

    def edit
        @order = Order.find(params[:id])
    end

    def update
        @order = Order.find(params[:id])
 
        if @order.update(order_params)
            redirect_to @order
        else
            render 'edit'
        end
    end

    def destroy
        @order = Order.find(params[:id])
        @order.destroy

        redirect_to orders_path
    end

    private
        def order_params
            params.require(:order).permit(:search)
        end
end
