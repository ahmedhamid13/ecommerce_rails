class Api::ProductsController < ApplicationController
    before_action :authenticate_user!, :except => [:index , :show]

    respond_to :json

    def index
        respond_with Product.all
    end
    def show
        respond_with Product.find(params[:id])
      end
end
