class UserMailer < MailerBase
  def reset_password(user)
    # @link =
    mail :to => user.email
  end

  def email_confirmation
    # @link =
    mail :to => user.email
  end
end
