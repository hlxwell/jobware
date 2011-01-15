class UserMailer < MailerBase
  sendgrid_category "itjob"

  def reset_password(user)
    @user = user
    @link = edit_password_url(user.perishable_token)

    build_header do
    #   to user.email
    #   category 'itjob'
    #   filter 'footer' do
    #     setting 'enable' => 1, 'text/plain' => "From ITJob.fm"
    #   end
    end

    mail :to => user.email, :subject => "ITJob.fm：重设密码"
  end

  def send_confirmation(user)
    @user = user
    @link = email_confirmation_url(user.perishable_token)
    mail :to => user.email, :subject => "ITJob.fm：邮件确认信"
  end
end