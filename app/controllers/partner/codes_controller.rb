class Partner::CodesController < Partner::BaseController
  def show
    if current_user.partner.has_partner_site?
      @rss_url = "http://#{current_user.partner.partner_site_style.try(:subdomain)}.itjob.fm/jobs.atom"
    end
  end

  def update_widget_js_code
    subdomain = current_user.try(:partner).try(:partner_site_style).subdomain
    @host = subdomain.blank? ? "itjob.fm" : "#{subdomain}.itjob.fm"
    render :partial => "partner/codes/sidebar_ad_code"
  end
end