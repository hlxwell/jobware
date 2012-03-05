# -*- encoding : utf-8 -*-
class Jobseeker::BaseController < ApplicationController
  layout "jobseeker"
  before_filter :jobseeker_login_required
end
