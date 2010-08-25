class Partner::AdPositionsController < Partner::BaseController
  def index
    @ad_positions = Partner::adPosition.all
  end

  def show
    @ad_position = Partner::adPosition.find(params[:id])
  end

  def new
    @ad_position = Partner::adPosition.new
  end

  def create
    @ad_position = Partner::adPosition.new(params[:ad_position])
    if @ad_position.save
      flash[:notice] = "Successfully created ad position."
      redirect_to @ad_position
    else
      render :action => 'new'
    end
  end

  def edit
    @ad_position = Partner::adPosition.find(params[:id])
  end

  def update
    @ad_position = Partner::adPosition.find(params[:id])
    if @ad_position.update_attributes(params[:ad_position])
      flash[:notice] = "Successfully updated ad position."
      redirect_to @ad_position
    else
      render :action => 'edit'
    end
  end

  def destroy
    @ad_position = Partner::adPosition.find(params[:id])
    @ad_position.destroy
    flash[:notice] = "Successfully destroyed ad position."
    redirect_to ad_positions_url
  end
end
