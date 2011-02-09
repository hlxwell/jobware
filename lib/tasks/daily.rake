task :daily => [
  :check_expired_ads_and_jobs,
  :check_permalinks,
  :relaunch_jobs_and_ads
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

desc "relaunch 20 old jobs"
task :relaunch_jobs_and_ads => :environment do
  puts "=== Total closed jobs: #{Job.closed.count}"
  Job.closed.limit(20).order('id desc').all.each_with_index do |j, i|
    puts "-=-=-=-= processing job##{i}"
    j.force_open!
  end

  puts "=== Total closed ads: #{Ad.closed.count}"
  Ad.closed.limit(20).order('id desc').all.each_with_index do |a, i|
    puts "-=-=-=-= processing ad##{i}"
    a.force_open!
  end
end