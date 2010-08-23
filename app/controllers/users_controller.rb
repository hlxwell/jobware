class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(params[:user])
      redirect_to("/", :notice => 'User was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      # UserSession.create(params[:user])
      redirect_to("/", :notice => 'User was successfully created.')
    else
      render :action => :new
    end
  end
end
