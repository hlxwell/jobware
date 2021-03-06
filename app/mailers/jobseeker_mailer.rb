# -*- encoding : utf-8 -*-
class JobseekerMailer < MailerBase
  def newsletter(jobseeker, jobs)
    @jobs = jobs
    mail :to => jobseeker.user.email, :subject => "ITJob.fm：最新工作机会"
  end

  def app_been_accepted(jobseeker, app)
    @jobseeker = jobseeker
    @app_job_name = app.job.name
    @app_mail_message = app.mail_message
    mail :to => jobseeker.user.email, :subject => "ITJob.fm：恭喜您，您的应聘被公司接受了"
  end

  def app_been_checked(jobseeker, app)
    @jobseeker = jobseeker
    @app_job_name = app.job.name
    mail :to => jobseeker.user.email, :subject => "ITJob.fm：您的应聘被公司查看了"
  end

  def app_been_rejected(jobseeker, app)
    @jobseeker = jobseeker
    @app_job_name = app.job.name
    @app_mail_message = app.mail_message
    mail :to => jobseeker.user.email, :subject => "ITJob.fm：您的应聘被公司拒绝了"
  end

  def app_been_starred(jobseeker, app)
    @jobseeker = jobseeker
    @app_job_name = app.job.name
    mail :to => jobseeker.user.email, :subject => "ITJob.fm：恭喜您，您的应聘被公司关注了"
  end
end
