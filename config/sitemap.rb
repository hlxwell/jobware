# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://itjob.fm"
SitemapGenerator::Sitemap.yahoo_app_id = "eDxJEwvV34GRHfVWnsaJPk08DfVCgDtZag.H9dsKTtXbj9eRoaNXEJYXzg.Jyw--"
SitemapGenerator::Sitemap.add_links do |sitemap|
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: sitemap.add path, options
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host

  sitemap.add jobs_path, :priority => 1, :changefreq => 'daily'
  Job.opened.all.each do |j|
    sitemap.add job_path(j), :lastmod => j.updated_at
  end

  sitemap.add jobs_path, :priority => 0.8, :changefreq => 'daily'
  Company.all.each do |c|
    sitemap.add company_path(c), :lastmod => c.updated_at
  end

  sitemap.add new_company_path, :priority => 0.3, :changefreq => 'weekly'
  sitemap.add new_partner_path, :priority => 0.3, :changefreq => 'weekly'
  sitemap.add new_jobseeker_resume_path, :priority => 0.3, :changefreq => 'weekly'
  sitemap.add "/aboutus", :priority => 0.3, :changefreq => 'weekly'
  sitemap.add "/law", :priority => 0.3, :changefreq => 'weekly'
  sitemap.add "/contactus", :priority => 0.3, :changefreq => 'weekly'
  sitemap.add "/term", :priority => 0.3, :changefreq => 'weekly'
  sitemap.add "/ad_service", :priority => 0.3, :changefreq => 'weekly'
end

# Including Sitemaps from Rails Engines.
#
# These Sitemaps should be almost identical to a regular Sitemap file except
# they needn't define their own SitemapGenerator::Sitemap.default_host since
# they will undoubtedly share the host name of the application they belong to.
#
# As an example, say we have a Rails Engine in vendor/plugins/cadability_client
# We can include its Sitemap here as follows:
#
# file = File.join(Rails.root, 'vendor/plugins/cadability_client/config/sitemap.rb')
# eval(open(file).read, binding, file)