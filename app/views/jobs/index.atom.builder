atom_feed(
  :language => "zh-CN",
  :root_url => jobs_url,
  :url => jobs_url(:format => :atom)
  ) do |feed|
  feed.title("ITJob.FM 最新工作情报 - 专注于程序员招聘")
  feed.link jobs_url
  feed.description "专注于程序员招聘"
  feed.updated(@jobs.empty? ? Time.now : @jobs.first.updated_at)

  @jobs.each do |job|
    feed.entry(job) do |entry|
      entry.title "#{job.location} - #{job.name} - #{job.company.name}"
      entry.link job_url(job)
      entry.summary truncate(strip_tags(job.atom_summary), :length => 300)
      entry.content job.atom_content, :type => 'html'
      entry.tag!('app:edited', job.updated_at)
      entry.author do |author|
        author.name(job.company.name)
      end
    end
  end
end