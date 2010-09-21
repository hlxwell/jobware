class PartnersController < ApplicationController
  layout "partner", :only => :edit
  layout "application", :except => :edit

  before_filter :partner_login_required, :approved_partner_required, :except => [:new, :create, :partner_site_header, :partner_site_footer]
  before_filter :no_partner_login_required, :only => [:new, :create]


  def partner_site_header
    render :layout => "all_link_target_blank_page"
  end

  def partner_site_footer
    render :layout => "all_link_target_blank_page"
  end

  def edit
    @partner = current_user.partner
    render :layout => "partner"
  end

  def update
    @partner = current_user.partner
    if @partner.update_attributes(params[:partner])
      redirect_to edit_partner_path, :notice => "合作站信息更新成功。"
    else
      render :action => 'edit', :layout => "partner"
    end
  end

  def new
    @partner = Partner.new
    @partner.build_user
  end

  def create
    @partner = Partner.new(params[:partner])
    @partner.user = current_user if current_user

    if @partner.save
      redirect_to partner_dashboard_path, :notice => "合作站创建成功。"
    else
      render :action => 'new'
    end
  end
end
