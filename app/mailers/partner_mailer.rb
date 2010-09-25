class PartnerMailer < MailerBase
  def approval(partner)
    mail :to => partner.user.email
  end

  def daily_report(partner)
    mail :to => partner.user.email
  end

  def monthly_report(partner)
    mail :to => partner.user.email
  end
end
