# This module is included in your application controller which makes
# several methods available to all controllers and views. Here's a
# common example you might add to your application layout file.
#
#   <% if logged_in? %>
#     Welcome <%= current_user.username %>! Not you?
#     <%= link_to "Log out", logout_path %>
#   <% else %>
#     <%= link_to "Sign up", signup_path %> or
#     <%= link_to "log in", login_path %>.
#   <% end %>
#
# You can also restrict unregistered users from accessing a controller using
# a before filter. For example.
#
#   before_filter :login_required, :except => [:index, :show]

module Authentication
  def self.included(controller)
    controller.send :helper_method, :current_user, :logged_in?, :redirect_back_or_default
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def logged_in?
    current_user
  end
  
  def not_logged_in?
    !logged_in?
  end

  def no_login_required
    if logged_in?
      store_target_location
      flash[:notice] = "你必需退出才能访问该页面。"
      redirect_to root_path
    end
  end

  def login_required
    unless logged_in?
      store_target_location
      flash[:error] = "你必需登陆才能访问该页面."
      redirect_to login_path
    end
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

private

  def store_target_location
    session[:return_to] = request.request_uri
  end
end
