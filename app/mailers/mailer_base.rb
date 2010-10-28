class MailerBase < ActionMailer::Base
  layout 'mail'
  default :from => "ITJob.fm程序员招聘网 <info@itjob.fm>"
  default_url_options[:host] = "itjob.fm"
end