class DashboardController < ApplicationController
  before_filter :company_login_required, :only => :company
  before_filter :jobseeker_login_required, :only => :jobseeker
  before_filter :partner_login_required, :only => :partner

  def jobseeker
    @resume = current_user.jobseeker
    @applications = @resume.job_applications.limit(3).includes('job')
    render :layout => "jobseeker"
  end

  def company
    @company = current_user.company
    @applications = @company.job_applications.order("id desc").limit(5).unread
    render :layout => "company"
  end

  def partner
    @partner_job_counters             = @partner.job_counters
    @partner_company_counters         = @partner.company_counters
    @partner_job_application_counters = @partner.job_application_counters
    @partner_jobseeker_counters       = @partner.jobseeker_counters
    @partner                          = current_user.partner
    render :layout => "partner"
  end
end
