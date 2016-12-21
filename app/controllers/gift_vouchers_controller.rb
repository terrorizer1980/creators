class GiftVouchersController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_gift_voucher, only: [:show, :edit, :update, :destroy]
  before_action :set_basket, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource  

  # GET /gift_vouchers
  # GET /gift_vouchers.json
  def index
    @gift_vouchers = current_user.gift_vouchers.not_claimed
  end

  # GET /gift_vouchers/1
  # GET /gift_vouchers/1.json
  def show
  end

  # GET /gift_vouchers/new
  def new
    @gift_voucher = GiftVoucher.new
  end

  # GET /gift_vouchers/1/edit
  def edit
  end

  # POST /gift_vouchers
  # POST /gift_vouchers.json
  def create
    @gift_voucher = GiftVoucher.new(gift_voucher_params)

    respond_to do |format|
      if @gift_voucher.save
        format.html { redirect_to @gift_voucher, notice: 'Gift voucher was successfully created.' }
        format.json { render :show, status: :created, location: @gift_voucher }
      else
        format.html { render :new }
        format.json { render json: @gift_voucher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gift_vouchers/1
  # PATCH/PUT /gift_vouchers/1.json
  def update
    respond_to do |format|
      if @gift_voucher.update(gift_voucher_params)
        format.html { redirect_to @gift_voucher, notice: 'Gift voucher was successfully updated.' }
        format.json { render :show, status: :ok, location: @gift_voucher }
      else
        format.html { render :edit }
        format.json { render json: @gift_voucher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gift_vouchers/1
  # DELETE /gift_vouchers/1.json
  def destroy
    @gift_voucher.destroy
    respond_to do |format|
      format.html { redirect_to gift_vouchers_url, notice: 'Gift voucher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gift_voucher
      @gift_voucher = GiftVoucher.find(params[:id])
    end
  
    def set_basket
      @basket = current_user.basket
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gift_voucher_params
      params.require(:gift_voucher).permit(:name, :message, :from_user_id, :user_id)
    end
end
