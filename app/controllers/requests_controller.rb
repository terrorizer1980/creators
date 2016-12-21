class RequestsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_request, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource  

  # GET /requests
  # GET /requests.json
  def index
  #  if current_user.staff?
      @requests = Request.all

   # else
    #  @requests = current_user.requests
    #end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    @assigned_to = User.find_by(@request.assigned_to).profile.nickname
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)
    @request.user_id = current_user.id
    if params[:reqtype] == "artist"
      @request.assigned_to = User.find_by(id: current_user).profile.artist
    else #default to advisor queue
      @request.assigned_to = User.find_by(id: current_user).profile.advisor
    end
    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:channel_id, :reqtype)
    end
end
