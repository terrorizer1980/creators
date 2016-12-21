class MotionGraphicsController < PublishablesController
  before_filter :authenticate_user!
  before_action :set_motion_graphic, only: [:show, :edit, :update, :destroy, :get_custom_fields]

  load_and_authorize_resource

  # GET /motion_graphics
  # GET /motion_graphics.json
	def index
		set_motion_graphic_list
	end

  # GET /motion_graphics/1
  # GET /motion_graphics/1.json
  def show
  #  authorize! :show, @motion_graphic
  end

  # GET /motion_graphics/new
  def new
    @motion_graphic = MotionGraphic.new
  #  authorize! :create, @motion_graphic
  end

  # GET /motion_graphics/1/edit
  def edit
 #   authorize! :edit, @motion_graphic
  end
	
#  def customize
#	  authorize! :customize, @motion_graphic
#    @mg_order = Order.new
#    
#    @mg_order_item = OrderItem.new
#    @mg_order_item.order = @mg_order
#    @mg_order_item.purchasable = @motion_graphic
#    
#    # @mg_order_item.product = Product.find(@motion_graphic.product_id)
#    @product = Product.find(1)
#    @mg_order_item.product = @product
#    @mg_order_item.cost = @product.price
#    respond_to do |format|
#      format.html { redirect_to new_order_order_item_path([Basket.first_or_create.becomes(Order)], motion_graphic_id: @motion_graphic) }
#    end
#  end
	
  def get_custom_fields
      respond_to do |format|
        format.json { render :json => @motion_graphic.custom_fields}
      end
  end

  # POST /motion_graphics
  # POST /motion_graphics.json
  def create
    @motion_graphic = MotionGraphic.new()
    set_publishable_params(params[:motion_graphic], @motion_graphic)
    @motion_graphic.assign_attributes(motion_graphic_params)
    
    @motion_graphic.user_id = current_user.id
    set_motion_graphic_product(@motion_graphic)
    
    respond_to do |format|
      if @motion_graphic.save
        format.html { redirect_to @motion_graphic, notice: 'Motion graphic was successfully created.' }
        format.json { render :show, status: :created, location: @motion_graphic }
      else
        format.html { render :new }
        format.json { render json: @motion_graphic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /motion_graphics/1
  # PATCH/PUT /motion_graphics/1.json
  def update
    
    set_publishable_params(params[:motion_graphic], @motion_graphic)
    
    @motion_graphic.assign_attributes(motion_graphic_params)
    set_motion_graphic_product(@motion_graphic)
    
    respond_to do |format|
      if @motion_graphic.save
        format.html { redirect_to @motion_graphic, notice: 'Motion graphic was successfully updated.' }
        format.json { render :show, status: :ok, location: @motion_graphic }
      else
        format.html { render :edit }
        format.json { render json: @motion_graphic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /motion_graphics/1
  # DELETE /motion_graphics/1.json
  def destroy
    #authorize! :destroy, @motion_graphic

    @motion_graphic.destroy
    respond_to do |format|
      format.html { redirect_to motion_graphics_url, notice: 'Motion graphic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_motion_graphic
      @motion_graphic = MotionGraphic.friendly.find(params[:id])
    end
  
  def set_motion_graphic_product(mg)
    # Due to naming the lower third product with a dash, we need to treat it special... ain't that a bitch?
    if mg.category == 'lower_thirds'
      mg.product_id = MotionGraphicProduct.find_by(name: 'Motion Graphic - Lower-Third').id
    else 
      mg.product_id = MotionGraphicProduct.find_by(name: 'Motion Graphic - ' + mg.category.singularize.titlecase).id
    end 
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def motion_graphic_params
      params.require(:motion_graphic).permit(:category, :tag_list, :mgscope, :motion_graphic_collection_id, :custom_fields, :title, :content, :content_html, :summary_html, :vidurl, :remote_thumburl_url, :publish_at, :approved)
    end
	
	def set_motion_graphic_list
		@motion_graphics = MotionGraphic.all
		
		if (params[:category_id] != nil && params[:category_id] != "-1")
			@motion_graphics = @motion_graphics
              .where(category: params[:category_id].to_i)
		end
		
		if (params[:collection_id] != nil && params[:collection_id] != "-1")
			@motion_graphics = @motion_graphics
              .where(motion_graphic_collection_id: params[:collection_id].to_i)
		end
      
        @motion_graphics = @motion_graphics.paginate(:page => params[:page])
	end
end
