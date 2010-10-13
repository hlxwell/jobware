class MailerBase < ActionMailer::Base
  layout 'mail'
  default :from => "ITJob.fm程序员招聘网 <info@itjob.fm>"
  default_url_options[:host] = Rails.env == 'production' ? "itjob.fm" : "lvh.me:3000"
end