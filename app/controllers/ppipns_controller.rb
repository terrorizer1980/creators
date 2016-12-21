class PpipnsController < ApplicationController
  protect_from_forgery except: :create

  def index
    @ppipns = Ppipn.order("created_at DESC")
  end

  # POST /ppipns
  # POST /ppipns.json
  def create
    Ppipn.create!(params: params)
    render nothing: true
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def ppipn_params
      params.permit(:params)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_ppipn
      @ppipn = Ppipn.find(params[:id])
    end
end
