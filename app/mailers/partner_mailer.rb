class PartnerMailer < MailerBase
  def approval(partner)
    @partner = partner
    mail :to => partner.user.email, :subject => "ITJob.fm：加入合作站申请审核通过"
  end
  
  def reject(partner)
    @partner = partner
    mail :to => partner.user.email, :subject => "ITJob.fm：加入合作站申请被拒绝"
  end

  def daily_report(partner)
    mail :to => partner.user.email, :subject => "ITJob.fm：每日报告"
  end

  def monthly_report(partner)
    mail :to => partner.user.email, :subject => "ITJob.fm：每月报告"
  end
end
