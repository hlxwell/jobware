class Company::BaseController < ApplicationController
  layout "company"

  before_filter :company_login_required

  private

  def company_login_required
    if not_logged_in? or current_user.company.blank?
      flash[:error] = "你必须是公司才能访问公司后台！"
      store_target_location
      redirect_to login_path
    end
  end
end