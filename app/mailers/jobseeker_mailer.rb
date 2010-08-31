class JobseekerMailer < ActionMailer::Base
  default :from => "newsletter@itjob.fm"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.jobseeker_mailer.newsletter.subject
  #
  def newsletter(user, jobs)
    @jobs = jobs
    mail :to => user.email, :subject => "[ITJob.fm 订阅]最新工作机会"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.jobseeker_mailer.forgot_password.subject
  #
  def forgot_password
    @greeting = "Hi"

    mail :to => "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.jobseeker_mailer.welcome.subject
  #
  def welcome
    @greeting = "Hi"

    mail :to => "to@example.org"
  end
end
