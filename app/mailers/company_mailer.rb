class CompanyMailer < MailerBase
  def new_applicant(company, job_app)
    @company = company
    @job_app = job_app
    mail :to => company.user.email, :subject => "ITJob.fm：《#{job_app.job.name}》有个新的应聘等待您查看"
  end

  def job_approval(company, job)
    @company = company
    @job = job
    mail :to => company.user.email, :subject => "ITJob.fm：岗位审核通过"
  end

  def job_expired(company, job)
    @company = company
    @job = job
    mail :to => company.user.email, :subject => "ITJob.fm：岗位审核被拒绝"
  end

  def ad_approval(company, ad)
    @company = company
    @ad = ad
    mail :to => company.user.email, :subject => "ITJob.fm：广告审核通过"
  end

  def ad_expired(company, ad)
    @company = company
    @ad = ad
    mail :to => company.user.email, :subject => "ITJob.fm：广告审核被拒绝"
  end

  def daily_report(company)
    @company = company
    mail :to => company.user.email, :subject => "ITJob.fm：每日浏览情况报告"
  end
end
