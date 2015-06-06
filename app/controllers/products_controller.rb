class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  respond_to :html, :xml, :json, :bson, :csv, :text
  # GET /products
  # GET /products.json
#   before_filter :default_format_json
# # Set format to xml unless client requires a specific format
# # Works on Rails 3.0.9
#   def default_format_json
#     request.format = "bson" unless params[:format]
#   end

  def index
    debugger
    @products = Product.all
    respond_to do |format|
      format.html # index.html.erb
      format.bson { render json: @products }
      format.csv { render json: @products }
      format.xml  { render xml: @products }
      format.json { render json: @products }
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @products = @product.category
    # doc = {:hello => "world"}
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
      params.require(:product).permit(:name, :content, :category_id)
    end
end
