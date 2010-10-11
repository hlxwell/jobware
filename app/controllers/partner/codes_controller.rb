class Partner::CodesController < Partner::BaseController
  def show
    if current_user.partner.has_partner_site?
      @rss_url = "http://#{current_user.partner.partner_site_style.try(:subdomain)}.itjob.fm/jobs.atom"
    end
  end
end