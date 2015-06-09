class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json, :bson, :xml
  # GET /products
  # GET /products.json
#   before_filter :default_format_bson
# # Set format to xml unless client requires a specific format
# # Works on Rails 3.0.9
#   def default_format_bson
#     request.format = "bson" unless params[:format]
#   end
  def index
    @products = Product.all
      respond_to do |format|
      @products_bson1 = []
      @products_bson2 = []
      @products.each do |pro|
        @products_bson = BSON::Document.new(pro.attributes)
          @products_bson1.push(@products_bson)
          @products_bson2  = @products_bson1.to_bson
          format.html # index.html.erb
          format.bson { render json: @products_bson2 }
          format.json { render json: @products }
          format.xml  { render xml: @products }
    end
  end
end

def user_product_list
  if user_signed_in? && !current_user.products.empty?
    @current_user_products = current_user.products
    respond_to do |format|
      @current_user_bson1 = []
      @current_user_bson2 = []
      @current_user_products.each do |user_product|
        @user_bson = BSON::Document.new(user_product.attributes)
        @current_user_bson1.push(@user_bson)
        @current_user_bson2 = @current_user_bson1.to_bson
        format.html # index.html.erb
          format.bson { render json: @current_user_bson2 }
          format.json { render json: @current_user_products }
          format.xml  { render xml: @current_user_products }
        end
    end
  else
      redirect_to products_path 
  end
end

def testing
  @product = Product.first
  @product = @product.category
  @product = @product.products
  respond_to do |format|
      @current_user_bson1 = []
      @current_user_bson2 = []
        @product.each do |user_product|
        @user_bson = BSON::Document.new(user_product.attributes)
        @current_user_bson1.push(@user_bson)
        @current_user_bson2 = @current_user_bson1.to_bson
        format.html # index.html.erb
          format.bson { render json: @current_user_bson2 }
          format.json { render json: @product }
          format.xml  { render xml: @product }
        end
    end
end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @product_bson = BSON::Document.new(@product.attributes)
    @product_bson  = @product_bson.to_bson
    respond_to do |format|
      format.html # index.html.erb
      format.bson { render json: @product_bson }
      format.xml  { render xml: @product }
      format.json { render json: @product }
    end
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.user_id = current_user._id
    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:user_id, :name, :content, :category_id)
    end
end
