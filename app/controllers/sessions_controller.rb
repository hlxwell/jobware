class SessionsController < ApplicationController
  before_filter :login_required, :only => :destroy
  # before_filter :no_login_required, :only => [:edit_password, :update_password]

  def new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:success] = "登陆成功。"
      redirect_back_or_default(dashboard_path_for(current_user))
    else
      flash[:error] = "错误的用户名或者密码！"
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to login_path, :notice => "退出登陆成功！"
  end

  def reset_password
    if params.get(:user, :email) and User.reset_password(params.get(:user, :email))
      flash[:message] = "<p class='success'>密码重置邮件已发送，请检查邮箱。</p>"
    elsif params.get(:user, :email)
      flash[:message] = "<p class='error'>邮箱填写错误或者不存在。</p>"
    end
  end

  def edit_password
    @user = User.find_using_perishable_token(params[:id])
    redirect_to login_path, :notice => "重置密码失败，请重新申请。" if @user.blank?
  end

  def update_password
    @user = User.find_by_id(params[:user].try(:delete, :user_id))

    if !params.get(:user, :password).blank? and 
       !params.get(:user, :password_confirmation).blank? and 
       @user.update_attributes!(params[:user])
      redirect_to login_path, :notice => '密码修改成功，您可以重新登录了。'
    else
      flash[:error] = "请输入正确的新密码。"
      render :action => "edit_password"
    end
  end
end