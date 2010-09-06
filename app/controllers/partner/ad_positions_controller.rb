class Partner::AdPositionsController < Partner::BaseController
  before_filter :get_ad_position_by_id, :only => [:show, :edit, :update, :destroy]

  def index
    @ad_positions = current_user.partner.ad_positions.all
  end

  def show
  end

  def new
    @ad_position = current_user.partner.ad_positions.build
  end

  def create
    @ad_position = current_user.partner.ad_positions.build(params[:ad_position])
    if @ad_position.save
      flash[:notice] = "Successfully created ad position."
      redirect_to partner_ad_position_path(@ad_position)
    else
      render :action => 'new'
    end
  end


  def edit
  end

  def update
    if @ad_position.update_attributes(params[:ad_position])
      flash[:notice] = "Successfully updated ad position."
      redirect_to partner_ad_position_path(@ad_position)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @ad_position.destroy
    flash[:notice] = "Successfully destroyed ad position."
    redirect_to partner_ad_positions_path
  end

  private
  def get_ad_position_by_id
    @ad_position = current_user.partner.ad_positions.find(params[:id])
  end
end
