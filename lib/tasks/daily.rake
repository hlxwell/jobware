task :daily => [
  :check_expired_ads_and_jobs,
  :check_permalinks
]

desc "check expired ads and jobs"
task :check_expired_ads_and_jobs => :environment do
  Ad.all.each(&:available?)
  Job.all.each(&:available?)
end

desc "check and new permalinks"
task :check_permalinks => :environment do
  %w{Company Job}.each do |class_name|
    class_name.constantize.all.each do |obj|
      obj.save if obj.permalink.blank?
    end
  end
end