module Api
  module V2
    class ProductsController < ApplicationController
      
    respond_to :html, :xml, :json, :bson

    before_filter :default_format

    def default_format
     request.format = "xml" unless params[:format]
    end

      def index
        respond_with Product.all
      end
      
      def show
        respond_with Product.find(params[:id])
      end
      
      def create
        respond_with Product.create(params[:product])
      end
      
      def update
        respond_with Product.update(params[:id], params[:products])
      end
      
      def destroy
        respond_with Product.destroy(params[:id])
      end
    end
  end
end