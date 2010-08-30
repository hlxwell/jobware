class Company::BaseController < ApplicationController
  layout "company"
  before_filter :company_login_required
  before_filter :get_new_job_application_count
end