ActiveMerchant::Billing::Integrations::Alipay::KEY     = "v8eqe23g0lgdre2726vn8f100g041jlx"
ActiveMerchant::Billing::Integrations::Alipay::ACCOUNT = "2088002016425361"
ActiveMerchant::Billing::Integrations::Alipay::EMAIL   = "hlxwell@hotmail.com"

class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery

  # before_filter :http_auth
  before_filter :set_locale, :current_partner_site
  helper_method :current_user_type, :current_user_section, :show_error_message_for, :current_partner_site, :current_layout

  layout :partner_site_or_main_site

  # go login page if access denied.
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to login_url
  end

  def current_layout
    if current_partner_site.present?
      "layouts/partner_site"
    else
      "layouts/application"
    end
  end

  def current_partner_site
    @current_partner_site = PartnerSiteStyle.find_by_subdomain(request.subdomain)
    @current_partner_site = nil if @current_partner_site.blank? or !@current_partner_site.partner.approved?
    @current_partner_site
  end

  def current_partner
     @current_partner_site.try(:partner)
  end

  def partner_site_or_main_site
    @current_partner_site.present? ? "partner_site" : "application"
  end

  def set_locale
    I18n.locale = params[:lang] || 'zh-CN'
  end

  def dashboard_path_for(user)
    ["jobseeker", "company", "partner"].each do |s|
      eval "return #{s}_dashboard_path if user.try(:#{s})"
    end
    return "/"
  end

  %w[jobseeker partner company].each do |method_name|
    helper_method "#{method_name}_user?"
    define_method("#{method_name}_user?") do |*args|
      logged_in? and current_user.send(method_name).present?
    end
  end

  def current_user_type
    [:jobseeker, :company, :partner].each do |role|
      return role.to_s if current_user.try(role).present?
    end
  end

  def current_user_section
    ["company", "jobseeker", "partner"].each do |section|
      return section if request.path =~ /^\/#{section}(.*)?/
    end
  end

  def show_error_message_for(obj)
    flash[:error] = "请根据错误提示填写正确内容。" if obj.errors.size > 0
  end

private

  def http_auth
    return if Rails.env != 'production'
    authenticate_or_request_with_http_basic do |username, password|
      username == "theplant" && password == "hangzhoubranch"
    end
  end

  def approved_partner_required
    unless current_user.partner.approved?
      flash[:error] = "你的合作站信息还在验证中，谢谢您的耐心等待。"
      redirect_to login_path
    end
  end

  ### define - xxx_login_required and no_xxx_login_required
  {:company => "公司", :jobseeker => "应聘者", :partner => "合作站"}.each do |key, value|
    define_method("#{key}_login_required") do |*args|
      if not_logged_in? or current_user.send(key).blank?
        store_target_location
        flash[:error] = "你必须登陆#{value}才能访问继续访问！ " #{session[:return_to]}
        respond_to do |format|
          format.html { redirect_to login_path }
          format.js { render :text => "$(location).attr('href', '#{login_path}');" }
        end
      end
    end

    define_method("no_#{key}_login_required") do |*args|
      if logged_in? and current_user.send(key).present?
        store_target_location
        flash[:error] = "你必须退出#{value}登陆才能够访问该页面！ " #{session[:return_to]}
        respond_to do |format|
          format.html { redirect_to login_path }
          format.js { render :text => "$(location).attr('href', '#{login_path}');" }
        end
      end
    end
  end
end