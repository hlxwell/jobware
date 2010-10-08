class AdminNotification < MailerBase

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.admin_notification.need_check.subject
  #
  def need_check(obj)
    @obj = obj
    mail :to => "itjob.fm@gmail.com", :subject => "ITJob.fm管理员：《#{obj.class}##{obj.id}》有个新发布的信息等待您审核"
  end
end