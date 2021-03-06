# -*- encoding : utf-8 -*-
# Controller generated by Typus, use it to extend admin functionality.
class Admin::UsersController < Admin::ResourcesController
  def login
    if !get_object.confirmed?
      redirect_to :back, :notice => "账户没有激活。"
    elsif UserSession.create(get_object)
      redirect_to "/", :notice => "登录 “#{get_object.email}” 成功。"
    else
      redirect_to :back, :notice => "登录失败。"
    end
  end

  def confirm
    get_object.confirm!
    redirect_to :back, :notice => "激活成功。"
  end
end
