class Admin::OrdersController < AdminController
  before_filter :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :increment_status, :decrement_status, :destroy]
  
  include Admin::OrdersHelper

  def index
    @orders = Purchase.all
    @orders = @orders.paginate(:page => params[:page])
  end
  
  def show
  end
    
  def edit
  end
    
  def update
  end
    
  def destroy
  end
  
  def increment_status
    @order.status = incrementEnum(@order.status, Order.statuses)
    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_url, notice: 'Order was successfully updated.' }
        format.json { render json: { curr_status: @order.status.humanize, curr_color: get_order_status_color(@order.status) }, status: :ok}
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def decrement_status
    @order.status = decrementEnum(@order.status, Order.statuses)
    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_url, notice: 'Order was successfully updated.' }
        format.json { render json: { curr_status: @order.status.humanize, curr_color: get_order_status_color(@order.status) }, status: :ok}
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
  def order_params
    params.require(:order).permit(:gift_voucher_id, :status, :notes)
  end
end