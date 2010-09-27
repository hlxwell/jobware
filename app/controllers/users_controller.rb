class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      # UserSession.create(params[:user])
      redirect_to("/", :notice => '用户注册成功。')
    else
      render :action => :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      redirect_to("/", :notice => '用户信息修改成功。')
    else
      render :action => "edit"
    end
  end
end
