class DashboardController < ApplicationController
  before_filter :company_login_required, :only => :company
  before_filter :jobseeker_login_required, :only => :jobseeker
  before_filter :partner_login_required, :only => :partner

  def company
    get_new_job_application_count
    render :layout => "company"
  end

  def jobseeker
    render :layout => "jobseeker"
  end

  def partner
    render :layout => "partner"
  end
end