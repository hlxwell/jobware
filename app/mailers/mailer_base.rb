class MailerBase < ActionMailer::Base
  layout 'mail'
  default :from => "ITJob.fm程序员招聘网 <info@itjob.fm>"
  default_url_options[:host] = "itjob.fm"

  sendgrid_header do
    category "itjob_production"

    filters {
      opentrack "enable" => 1
      clicktrack "enable" => 1
      subscriptiontrack "enable" => 0
      template "enable" => 0
      footer "enable" => 0
    }
  end
end