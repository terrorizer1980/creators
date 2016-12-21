class OrderItemsController < ApplicationController
  before_filter :authenticate_user!
  before_action :load_purchasable
  before_action :set_order_item, only: [:show, :edit, :update, :destroy, :add_to_basket, :add_to_wishlist]
  before_action :ensure_selected_channel_matches, only: [:show, :edit]
  before_action :set_parent_object, except: [:add_to_basket] 

  load_and_authorize_resource
  
  include OrderItemsHelper

  # GET /order_items
  # GET /order_items.json
  def index
    @order_items = @purchasable.order_items.where(channel_id: current_user.profile.selected_channel_id).where(order_id: nil)
  end

  # GET /order_items/1
  # GET /order_items/1.json
  def show

  end

  # GET /order_items/new
  def new
    @order_item = @purchasable.order_items.new
  end

  # GET /order_items/1/edit
  def edit
  end

  # POST /order_items
  # POST /order_items.json
  def create
    @purchasable = find_purchasable
    @order_item = @purchasable.order_items.new(order_item_params)
    @order_item.user_id = current_user.id
    @order_item.channel_id = current_user.profile.selected_channel_id
    @order_item.product = @purchasable.product
#    @order_item.cost = @purchasable.product.price
    
    respond_to do |format|
      if @order_item.save
        format.html { redirect_to [@purchasable, :order_items], notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @order_item }
      else
        format.html { render :new }
        format.json { render json: @purchasable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_items/1
  # PATCH/PUT /order_items/1.json
  def update
    @order_item.assign_attributes(order_item_params)
    
#    if(@order_item.product_id_changed?)
#      # TODO: Should probably just disable editing the Product once the order_item is created
#      @product = Product.find(@order_item.product_id)
#      @order_item.cost = @order_item.product.price
#    end
    
    respond_to do |format|
      if @order_item.update(order_item_params)
        format.html { redirect_to @parent, notice: 'Order item was successfully updated.' }
        format.json { render :show, status: :ok, location: @order_item }
      else
        format.html { render :edit }
        format.json { render json: @purchasable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_items/1
  # DELETE /order_items/1.json
  def destroy
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to @parent, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def add_to_basket
    basket = current_user.basket
    basket_item = @order_item.dup
    basket_item.order = basket
    
    respond_to do |format|
      if basket_item.save
        format.html { redirect_to orders_basket_path, notice: 'Item was added to shopping basket.' }
        format.json { render :show, status: :ok, location: @order_item }
      else
        format.html { render :show }
        format.json { render json: @purchasable.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def add_to_wishlist
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  
  def set_parent_object
    if(@order_item.blank? || @order_item.new_record?)
      @parent = [@purchasable, :order_items]
    else
      unless(@order_item.order != nil && @order_item.order.type == 'Basket')
        @parent = find_order_item_parent(@order_item)
      else
        @parent = orders_basket_path
      end
    end
  end
  
  def set_order_item
    @order_item = @purchasable.order_items.find(params[:id])
  end
  
  def load_purchasable
    @purchasable = find_purchasable
  end

  def find_purchasable
    params.each do |name, value|
      if name =~ /(.+)_id$/  && (defined? $1.classify.constantize.friendly)
        return $1.classify.constantize.friendly.find(value)
      end
    end  
    nil  
  end
  
  def ensure_selected_channel_matches
    if @order_item.order.nil? && @order_item.channel_id != current_user.profile.selected_channel_id
      redirect_to [@purchasable, :order_items], notice: 'Selected channel was changed, customization was closed.'
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def order_item_params
    params.require(:order_item).permit(:name, :product_id, :custom, :cost, :ordered, :requested, :delivered)
  end
end