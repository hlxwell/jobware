class Partner::PartnerSiteStylesController < Partner::BaseController
  def show
    redirect_to edit_partner_partner_site_style_path
  end

  def edit
    @partner_site_style = current_user.partner.partner_site_style || current_user.partner.build_partner_site_style
  end

  def create
    @partner_site_style = current_user.partner.build_partner_site_style(params[:partner_site_style])
    if @partner_site_style.save
      redirect_to edit_partner_partner_site_style_path, :notice => "创建成功。"
    else
      render :action => 'edit'
    end
  end

  def update
    @partner_site_style = current_user.partner.partner_site_style
    if @partner_site_style.update_attributes(params[:partner_site_style])
      redirect_to edit_partner_partner_site_style_path, :notice => "更新成功。"
    else
      render :action => 'edit'
    end
  end
end