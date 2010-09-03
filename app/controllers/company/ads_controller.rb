class Company::AdsController < Company::BaseController
  before_filter :get_ad_by_id, :only => [:show, :edit, :update, :destroy]

  def index
    @ads = current_user.company.ads
  end

  def show
  end

  def new
    @ad = current_user.company.ads.build
    @ad.build_image
  end

  def create
    @ad = current_user.company.ads.build(params[:ad])

    if @ad.save
      redirect_to company_ad_path(@ad), :notice => "广告创建成功。"
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @ad.update_attributes(params[:ad])
      redirect_to company_ad_path(@ad), :notice => "广告更新成功。"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @ad.destroy
    flash[:success] = "删除广告成功。"
    redirect_to company_ads_path
  end

private

  def get_ad_by_id
    @ad = current_user.company.ads.find params[:id]
  end
end