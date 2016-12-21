class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_order, only: [ :show, :purchase_items, :clear_gift_voucher ]
  before_action :set_order_items, only: [ :show, :purchase_items ]
  before_action :set_credits, only: [ :show, :purchase_items ]
  before_filter :set_gift_vouchers, only: [ :show, :purchase_items ]
  load_and_authorize_resource

  # GET /orders
  # GET /orders.json
  def index
    @orders = current_user.purchases
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @order.user = current_user
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.user = current_user

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

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      unless @order.to_subclass.locked
        if @order.update(order_params)
          format.html { redirect_to orders_basket_path, notice: 'Order was successfully updated.' }
          format.json { render :show, status: :ok, location: @order }
        else
          format.html { render :edit }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :show, alert: 'You cannot update a locked order' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def clear_gift_voucher
    respond_to do |format|
      unless @order.to_subclass.locked
        if @order.update(:gift_voucher_id => nil)
          format.html { redirect_to orders_basket_path, notice: 'Order was successfully updated.' }
          format.json { render :show, status: :ok, location: @order }
        else
          format.html { render :edit }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :show, alert: 'You cannot update a locked order' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def purchase_items
    # TODO: Add the transactions to adjust the user's credit balance
    total_items = 0
    total_credits = 0.0
    total_discount = 0.0
    current_discount = 0.0
    used_items = []
    
    new_order = nil
    
    Order.transaction do 
      new_order = @order.dup.becomes(Purchase)
      new_order.type = 'Purchase'
      
      new_voucher = nil
      unless new_order.gift_voucher_id.nil?
        new_voucher = new_order.gift_voucher.dup
        new_voucher.status = 'claimed'
        new_voucher.save!
        
        new_order.gift_voucher_id = new_voucher.id
      end
      new_order.save!
      
      @order_items.each do | order_item | 
        order_item.cost = order_item.product.price
        order_item.order_id = new_order.id
        order_item.save!
        
        if @order.gift_voucher.present?
          matched_gift_voucher_item = @order.gift_voucher.gift_voucher_items.not_claimed.where.not(:id => used_items).find_by(product_id: order_item.product_id)
          if matched_gift_voucher_item != nil
            current_discount = order_item.product.price * matched_gift_voucher_item.discount / 100
            total_discount += current_discount
            used_items << matched_gift_voucher_item.id
            
            new_gift_voucher_item = matched_gift_voucher_item.dup
            new_gift_voucher_item.gift_voucher_id = new_voucher.id
            new_gift_voucher_item.save!
            
            matched_gift_voucher_item.update(status: 'claimed')
          end
        end
        
        total_items += 1
        total_credits += order_item.cost
      end
      
      total_charge = (total_credits - total_discount)
      
      gift_voucher = @order.gift_voucher
      unless gift_voucher.nil?
        remaining_gift_voucher_items = gift_voucher.gift_voucher_items.where.not(status: GiftVoucherItem.statuses['claimed'])
        if remaining_gift_voucher_items.count == 0
          gift_voucher.status = 'claimed'
          gift_voucher.save!

          @order.gift_voucher_id = nil
          @order.save!
        else
          gift_voucher.status = 'partial'
          gift_voucher.save!
        end
      end
      
      curr_tx = current_user.txes.last
      
      if @credits >= total_charge
        new_tx = current_user.txes.new
        new_tx.assign_attributes(
          txtype: 'spend_credits', 
          currency: 'credits', 
          direction: 'purchase',
          amount_credits: total_charge,
          balance_credits: @credits - total_charge,
          balance_cents: curr_tx.blank? ? 0 : curr_tx.balance_cents,
          order_id: new_order.id, 
          notes: new_order.notes
          )
        new_tx.save!
        
        log_to_hipchat('User ' + current_user.email + ' has successfully made a purchase(order_id: ' + new_order.id.to_s + '), on ' + Rails.env)
      else
        log_to_hipchat('User ' + current_user.email + ' attempted a purchase with insufficient credits, on ' + Rails.env)
        
        raise ActiveRecord::Rollback
      end
    end
    
    # TODO: render the confirm page? Redirect to basket? Show purchase?
    respond_to do |format|
      format.html { redirect_to new_order.becomes(Order), notice: 'Order was processed.' }
      format.json { head :no_content }
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_items
      @order_items = @order.order_items
    end

    def set_order
      @order = params[:id] == 'basket' ? current_user.basket.becomes(Order) : Order.find(params[:id]).becomes(Order)
      #@order = Order.find(params[:id]).becomes(Order)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:notes, :gift_voucher_id)
    end
end