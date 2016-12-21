class GiftVoucherItemsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_gift_voucher_item, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource  

  # GET /gift_voucher_items
  # GET /gift_voucher_items.json
  def index
    @gift_voucher_items = GiftVoucherItem.all
  end

  # GET /gift_voucher_items/1
  # GET /gift_voucher_items/1.json
  def show
  end

  # GET /gift_voucher_items/new
  def new
    @gift_voucher_item = GiftVoucherItem.new
  end

  # GET /gift_voucher_items/1/edit
  def edit
  end

  # POST /gift_voucher_items
  # POST /gift_voucher_items.json
  def create
    @gift_voucher_item = GiftVoucherItem.new(gift_voucher_item_params)

    respond_to do |format|
      if @gift_voucher_item.save
        format.html { redirect_to @gift_voucher_item, notice: 'Gift voucher item was successfully created.' }
        format.json { render :show, status: :created, location: @gift_voucher_item }
      else
        format.html { render :new }
        format.json { render json: @gift_voucher_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gift_voucher_items/1
  # PATCH/PUT /gift_voucher_items/1.json
  def update
    respond_to do |format|
      if @gift_voucher_item.update(gift_voucher_item_params)
        format.html { redirect_to @gift_voucher_item, notice: 'Gift voucher item was successfully updated.' }
        format.json { render :show, status: :ok, location: @gift_voucher_item }
      else
        format.html { render :edit }
        format.json { render json: @gift_voucher_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gift_voucher_items/1
  # DELETE /gift_voucher_items/1.json
  def destroy
    @gift_voucher_item.destroy
    respond_to do |format|
      format.html { redirect_to gift_voucher_items_url, notice: 'Gift voucher item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gift_voucher_item
      @gift_voucher_item = GiftVoucherItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gift_voucher_item_params
      params.require(:gift_voucher_item).permit(:name, :description, :gift_voucher_id, :product_id, :discount, :quantity, :status)
    end
end
