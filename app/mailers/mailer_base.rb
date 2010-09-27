class MailerBase < ActionMailer::Base
  layout 'mail'
  default :from => "ITJob.fm <notifier@itjob.fm>"
  default_url_options[:host] = Rails.env == 'production' ? "itjob.fm" : "lvh.me:3000"
end