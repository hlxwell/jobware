class CompanyMailer < ActionMailer::Base
  default :from => "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.company_mailer.new_applicant.subject
  #
  def new_applicant
    @greeting = "Hi"

    mail :to => "to@example.org"
  end
  
  def job_approved
    
  end
end
