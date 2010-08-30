class Tracker < ActionController::Metal
  # include ActionController::Rendering
  include ActionController::RequestForgeryProtection
  include Rails.application.routes.url_helpers
  include ActionController::Redirecting
  protect_from_forgery

  def track
    @adurl = params[:adurl] || "/"
    Adclick.create(
      :ad_position_id => params[:adid],
      :remote_ip => request.ip,
      :source_page => request.headers["HTTP_REFERER"],
      :dest_page => params[:adurl],
      :http_user_agent => request.headers["HTTP_USER_AGENT"],
      :remote_host => request.headers["REMOTE_HOST"],
      :request_uri => request.headers["REQUEST_URI"]
    )

    redirect_to @adurl
  rescue ActionController::InvalidAuthenticityToken
    redirect_to @adurl
  end
end