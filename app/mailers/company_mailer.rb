class CompanyMailer < MailerBase
  def new_applicant(company, job_app)
    @company = company
    @job_app = job_app
    mail :to => company.user.email
  end

  def job_approval(company, job)
    @company = company
    @job = job
    mail :to => company.user.email
  end

  def job_expired(company, job)
    @company = company
    @job = job
    mail :to => company.user.email
  end

  def ad_approval(company, ad)
    @company = company
    @ad = ad
    mail :to => company.user.email
  end

  def ad_expired(company, ad)
    @company = company
    @ad = ad
    mail :to => company.user.email
  end

  def daily_report(company)
    @company = company
    mail :to => company.user.email
  end
end
