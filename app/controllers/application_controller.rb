require 'lib/authentication'
class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery

  before_filter :set_locale

  # go login page if access denied.
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to login_url
  end

  def set_locale
    I18n.locale = params[:lang] || 'zh-CN'
  end

  %w[jobseeker partner company].each do |method_name|
    helper_method "#{method_name}_user?"
    define_method("#{method_name}_user?") do |*args|
      logged_in? and current_user.send(method_name).present?
    end
  end

private

  ### define - xxx_login_required and no_xxx_login_required
  {:company => "公司", :jobseeker => "应聘者", :partner => "合作站"}.each do |key, value|
    define_method("#{key}_login_required") do |*args|
      if not_logged_in? or current_user.send(key).blank?
        store_target_location
        flash[:error] = "你必须是#{value}才能访问#{value}后台！"
        redirect_to login_path
      end
    end

    define_method("no_#{key}_login_required") do |*args|
      if logged_in? and current_user.send(key).present?
        store_target_location
        flash[:error] = "你必须退出#{value}登陆才能够访问该页面！"
        redirect_to login_path
      end
    end
  end
end