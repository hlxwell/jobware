class DashboardController < ApplicationController
  before_filter :company_login_required, :only => :company
  before_filter :jobseeker_login_required, :only => :jobseeker
  before_filter :partner_login_required, :approved_partner_required, :only => :partner

  def jobseeker
    @resume = current_user.jobseeker
    @applications = @resume.job_applications.limit(10)
    @latest_applications = @resume.job_applications.limit(3).includes('job')

    render :layout => "jobseeker"
  end

  def company
    @company = current_user.company
    @applications = @company.job_applications.order("id desc").limit(5).unread
    @company_view_counters = @company.counters.limit(10)
    @company_job_view_counters = @company.job_counters.limit(10)
    @company_job_applications_counters = @company.job_applications.limit(10)

    render :layout => "company"
  end

  def partner
    @partner                          = current_user.partner
    @partner_job_counters             = @partner.job_counters.limit(10)
    @partner_company_counters         = @partner.company_counters.limit(10)
    @partner_job_application_counters = @partner.job_application_counters.limit(10)
    @partner_jobseeker_counters       = @partner.jobseeker_counters.limit(10)
    render :layout => "partner"
  end
end
