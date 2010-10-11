task :daily => [
  :check_expired_ads_and_jobs
]

desc "check expired ads and jobs"
task :check_expired_ads_and_jobs => :environment do
  Ad.opened.each(&:available?)
  Job.opened.each(&:available?)
end