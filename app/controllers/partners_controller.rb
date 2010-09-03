class PartnersController < ApplicationController
  before_filter :partner_login_required
  layout "partner", :only => :edit
  layout "application", :except => :edit
  
  def show
    @partner = current_user.partner
  end

  def edit
    @partner = current_user.partner
  end

  def update
    @partner = current_user.partner
    if @partner.update_attributes(params[:partner])
      redirect_to edit_partner_path, :notice => "合作站信息更新成功。"
    else
      render :action => 'edit'
    end
  end

  def new
    @partner = Partner.new
    @partner.build_user
  end

  def create
    @partner = Partner.new(params[:partner])
    @partner.build_user(params[:partner][:user_attributes])

    if @partner.save
      redirect_to partner_dashboard_path, :notice => "合作站创建成功。"
    else
      render :action => 'new'
    end
  end
end
