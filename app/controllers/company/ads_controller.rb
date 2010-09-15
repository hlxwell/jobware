class Company::AdsController < Company::BaseController
  before_filter :get_ad_by_id, :only => [:show, :edit, :update, :destroy]

  def index
    @ads = current_user.company.ads
  end

  def show
  end

  def new
    @ad = current_user.company.ads.build
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
    flash[:notice] = "不能修改展示中的广告，如需修改请联系我们。" if @ad.active?
  end

  def update
    redirect_to edit_company_ad_path(@ad) and return if @ad.active?

    if @ad.update_attributes(params[:ad])
      redirect_to company_ad_path(@ad), :notice => "广告更新成功。"
    else
      render :action => 'edit'
    end
  end

  def destroy
    if @ad.active?
      flash[:error] = "删除广告失败，不能删除展示中的广告。"
    else
      @ad.destroy
      flash[:success] = "删除广告成功。"
    end

    redirect_to company_ads_path
  end

private

  def get_ad_by_id
    @ad = current_user.company.ads.find params[:id]
  end
end