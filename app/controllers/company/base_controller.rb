class Company::BaseController < ApplicationController
  layout "company"
  before_filter :company_login_required
end