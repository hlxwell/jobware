desc "Send mail to tell admin the latest added data."
task :send_latest_data => :environment do
  time_mark_file_path = File.join(Rails.root, 'tmp', 'last_notification_send_at')

  # read last sent time, if blank, set current time.
  begin
    last_sent_at = File.read(time_mark_file_path).to_time
    raise if last_sent_at.blank?
  rescue
    last_sent_at = Time.now
  ensure
    File.open(time_mark_file_path, "w") do |f|
      f.write(Time.now)
    end
  end

  # find data
  data_hash = {}

  NewDataNotifier.be_monitored_models.each do |model|
    data_hash[model.downcase.to_sym] = model.constantize.all :conditions => ["created_at < ?", last_sent_at], :order => "created_at DESC"
  end

  data_hash.delete_if { |key, value| value.blank? }

  # send mail
  unless data_hash.select { |key, value| value.size > 0 }.blank?
    NewDataNotifier.notification(data_hash).deliver
  end
end