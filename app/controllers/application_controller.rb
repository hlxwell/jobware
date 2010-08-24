require 'lib/authentication'
class ApplicationController < ActionController::Base
  include Authentication
  protect_from_forgery

  before_filter :set_locale

  def set_locale
    I18n.locale = params[:lang] || 'zh-CN'
  end

  %w[jobseeker partner company].each do |method_name|
    helper_method "#{method_name}_user?"
    define_method("#{method_name}_user?") do |*args|
      logged_in? and current_user.send(method_name).present?
    end
  end
end