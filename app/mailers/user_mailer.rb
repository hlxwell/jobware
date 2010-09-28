class UserMailer < MailerBase
  def reset_password(user)
    @user = user
    @link = edit_password_url(user.perishable_token)
    mail :to => user.email, :subject => "ITJob.fm：重设密码"
  end

  def send_confirmation(user)
    @user = user
    @link = email_confirmation_url(user.perishable_token)
    mail :to => user.email, :subject => "ITJob.fm：邮件确认信"
  end
end