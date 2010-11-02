class Company::AdsController < Company::BaseController
  before_filter :get_ad_by_id, :only => [:show, :edit, :update, :destroy, :want_to_show]

  def index
    @ads = current_user.company.ads
  end

  def show
  end

  def plans
  end

  def new
    if params[:type].present? and %w{slider_ad urgent_job famous_company featured_company}.include?(params[:type])
      @ad = current_user.company.ads.build(:display_type => eval("AdPositionType::#{params[:type].upcase}"))
      @template = "company/ads/forms/#{params[:type]}"
    else
      @ad = current_user.company.ads.build
      @template = "company/ads/forms/form"
    end
  end

  def create
    @ad = current_user.company.ads.build(params[:ad])
    @ad.themes = current_theme_site

    if @ad.save
      redirect_to company_ad_path(@ad), :notice => "广告创建成功。"
    else
      @template = params[:type].present? ? "company/ads/forms/#{params[:type]}" : "company/ads/forms/form"
      render :action => 'new'
    end
  end

  def edit
    flash[:notice] = "不能修改展示中的广告，如需修改请联系我们。" if @ad.opened?
    @template = "company/ads/forms/#{@ad.display_type_key}"
  end

  def update
    redirect_to edit_company_ad_path(@ad) and return if @ad.opened?

    if @ad.update_attributes(params[:ad])
      redirect_to company_ad_path(@ad), :notice => "广告更新成功。"
    else
      render :action => 'edit'
    end
  end

  def destroy
    if @ad.opened?
      flash[:error] = "删除广告失败，不能删除展示中的广告。"
    else
      @ad.destroy
      flash[:success] = "删除广告成功。"
    end
    redirect_to company_ads_path
  end

  def want_to_show
    if @ad.want_to_show
      flash[:success] = "扣除#{@ad.period}点“#{@ad.display_type_humanize}”，广告正在审核中，如果审核通过则会显示在前台。"
    else
      flash[:error] = "扣除#{@ad.period}点“#{@ad.display_type_humanize}”失败，请充值后再激活。"
    end
    redirect_to company_ads_path
  end

private

  def get_ad_by_id
    @ad = current_user.company.ads.find params[:id]
  end
end