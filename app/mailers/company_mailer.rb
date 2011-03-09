class CompanyMailer < MailerBase
  def send_reset_account_password(company)
    @company_name = company.name
    @company_user_email = company.user.email
    @link = edit_password_url(company.user.perishable_token)
    mail :to => company.user.email, :subject => "ITJob.fm：招聘管理帐号确认" do |format|
      format.text
    end
  end

  def new_applicant(company, job_app)
    @company_name = company.name
    @job_name = job_app.job.name
    @job_app_url = company_job_application_url(job_app)
    mail :to => company.user.email, :subject => "ITJob.fm：《#{job_app.job.name}》有个新的应聘等待您查看" do |format|
      format.text
    end
  end

  def job_approval(company, job)
    @company_name = company.name
    @job_name = job.name
    mail :to => company.user.email, :subject => "ITJob.fm：岗位审核通过" do |format|
      format.text
    end
  end

  def job_expired(company, job)
    @company_name = company.name
    @job_name = job.name
    mail :to => company.user.email, :subject => "ITJob.fm：岗位已经过期" do |format|
      format.text
    end
  end

  def ad_approval(company, ad)
    @company_name = company.name
    @ad_display_type_humanize = ad.display_type_humanize
    @ad_name = ad.ad_name
    mail :to => company.user.email, :subject => "ITJob.fm：广告审核通过" do |format|
      format.text
    end
  end

  def ad_expired(company, ad)
    @company_name = company.name
    @ad_display_type_humanize = ad.display_type_humanize
    @ad_name = ad.ad_name
    mail :to => company.user.email, :subject => "ITJob.fm：广告已经过期" do |format|
      format.text
    end
  end

  def daily_report(company)
    @company = company
    mail :to => company.user.email, :subject => "ITJob.fm：每日浏览情况报告" do |format|
      format.text
    end
  end
end
