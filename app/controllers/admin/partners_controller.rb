# Controller generated by Typus, use it to extend admin functionality.
class Admin::PartnersController < Admin::ResourcesController
  def approve
    if get_object.approve
      redirect_to :back, :notice => "审核通过。"
    else
      redirect_to :back, :notice => "不能审核已经通过审核的。"
    end
  end

  def reject
    if get_object.reject
      redirect_to :back, :notice => "审核不通过。"
    else
      redirect_to :back, :notice => "拒绝审核出错。"
    end
  end

  def send_commission
    amount = params.get(:commission, :amount)
    money_from = params.get(:commission, :money_from)

    if amount and money_from and amount.to_f > 0
      get_object.user.charge!(amount, :from => money_from)
      flash[:notice] = "付给#{get_object.name}#{money_from}#{amount}元成功。"
    else
      flash[:notice] = "请输入佣金数量和来源。"
    end
    redirect_to :back
  end
  
  def withdraw
    amount = params.get(:commission, :amount)
    money_to = params.get(:commission, :money_to)
    
    if amount and money_to and amount.to_f > 0
      get_object.user.withdraw!(amount, :to => money_to)
      flash[:notice] = "通过#{money_to}支付给#{get_object.name}#{amount}元成功。"
    else
      flash[:notice] = "请输入佣金数量和去处。"
    end
    redirect_to :back
  end
end
