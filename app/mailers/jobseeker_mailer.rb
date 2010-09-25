class JobseekerMailer < MailerBase
  def newsletter(jobseeker, jobs)
    @jobs = jobs
    mail :to => jobseeker.user.email, :subject => "[ITJob.fm 订阅]最新工作机会"
  end

  def app_been_accepted(jobseeker, app)
    mail :to => jobseeker.user.email, :subject => "[ITJob.fm 订阅]最新工作机会"
  end

  def app_been_checked(jobseeker, app)
    mail :to => jobseeker.user.email, :subject => "[ITJob.fm 订阅]最新工作机会"
  end

  def app_been_rejected(jobseeker, app)
    mail :to => jobseeker.user.email, :subject => "[ITJob.fm 订阅]最新工作机会"
  end

  def app_been_starred(jobseeker, app)
    mail :to => jobseeker.user.email, :subject => "[ITJob.fm 订阅]最新工作机会"
  end
end