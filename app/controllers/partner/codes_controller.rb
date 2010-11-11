class Partner::CodesController < Partner::BaseController
  before_filter :find_host

  def show
    if current_user.partner.has_partner_site?
      @rss_url = "http://#{current_user.partner.partner_site_style.try(:subdomain)}.itjob.fm/jobs.atom"
    end

    if %w{inline sidebar}.include?(params[:type])
      render params[:type]
    else
      redirect_to :action => :show, :type => "inline"
    end
  end

  def update_widget_js_code
    render :partial => "partner/codes/sidebar_ad_code"
  end
end