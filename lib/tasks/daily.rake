task :daily => [
  :check_expired_ads_and_jobs
]

desc "check expired ads and jobs"
task :check_expired_ads_and_jobs => :environment do
  Ad.all.each(&:available?)
  Job.all.each(&:available?)
end