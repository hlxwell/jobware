# -*- encoding : utf-8 -*-
class DashboardController < ApplicationController
  before_filter :company_login_required, :only => :company
  before_filter :jobseeker_login_required, :only => :jobseeker
  before_filter :partner_login_required, :only => :partner

  def jobseeker
    @resume = current_user.jobseeker
    @applications = @resume.job_applications
    @latest_applications = @resume.job_applications.limit(3).includes('job')

    render :layout => "jobseeker"
  end

  def company
    @company = current_user.company
    @applications = @company.job_applications.order("id desc").limit(5).unread
    @company_view_counters = @company.counters.all(:order => "id desc", :limit => 15).reverse
    @company_job_view_counters = @company.job_counters.all(:order => "id desc", :limit => 15).reverse
    @company_job_applications_counters = @company.job_applications

    render :layout => "company"
  end

  def partner
    @partner                          = current_user.partner
    @partner_job_counters             = @partner.job_counters.all(:order => "id desc", :limit => 15).reverse
    @partner_company_counters         = @partner.company_counters.all(:order => "id desc", :limit => 15).reverse
    @partner_job_application_counters = @partner.job_application_counters.all(:order => "id desc", :limit => 15).reverse
    @partner_jobseeker_counters       = @partner.jobseeker_counters.all(:order => "id desc", :limit => 15).reverse
    render :layout => "partner"
  end
end
