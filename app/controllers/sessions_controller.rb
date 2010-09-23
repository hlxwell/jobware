class SessionsController < ApplicationController
  before_filter :login_required, :only => :destroy

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
end