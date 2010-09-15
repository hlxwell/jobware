class DashboardController < ApplicationController
  before_filter :company_login_required, :only => :company
  before_filter :jobseeker_login_required, :only => :jobseeker
  before_filter :partner_login_required, :only => :partner

  def jobseeker
    @resume = current_user.jobseeker
    @job_applications = @resume.job_applications.limit(3).includes('job')
    render :layout => "jobseeker"
  end

  def company
    @company = current_user.company
    @applications = @company.job_applications.order("id desc").limit(5).unread
    render :layout => "company"
  end

  def partner
    render :layout => "partner"
  end
end