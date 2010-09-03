class JobseekerMailer < ActionMailer::Base
  default :from => "newsletter@itjob.fm"

  def newsletter(user, jobs)
    @jobs = jobs
    mail :to => user.email, :subject => "[ITJob.fm 订阅]最新工作机会"
  end
end
