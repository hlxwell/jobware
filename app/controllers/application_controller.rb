require 'lib/authentication'
class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery

  before_filter :set_locale

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

  def company_login_required
    if not_logged_in? or current_user.company.blank?
      flash[:error] = "你必须是公司才能访问公司后台！"
      store_target_location
      redirect_to login_path
    end
  end

  def partner_login_required
    if not_logged_in? or current_user.partner.blank?
      flash[:error] = "你必须是合作者才能访问合作者后台！"
      store_target_location
      redirect_to login_path
    end
  end

  def jobseeker_login_required
    if not_logged_in? or current_user.jobseeker.blank?
      flash[:error] = "你必须是应聘者才能访问应聘者后台！"
      store_target_location
      redirect_to login_path
    end
  end
end