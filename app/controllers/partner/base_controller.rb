# -*- encoding : utf-8 -*-
class Partner::BaseController < ApplicationController
  layout "partner"
  before_filter :partner_login_required
end
