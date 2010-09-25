class CompanyMailer < MailerBase
  def new_applicant(company, job_app)
    mail :to => company.user.email
  end

  def job_approval(company, job)
    mail :to => company.user.email
  end

  def job_expired(company, job)
    mail :to => company.user.email
  end

  def ad_approval(company, ad)
    mail :to => company.user.email
  end

  def ad_expired(company, ad)
    mail :to => company.user.email
  end

  def daily_report(company)
    mail :to => company.user.email
  end
end
