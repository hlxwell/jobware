class TransactionsController < ApplicationController

  def index
    @money_transactions = current_user.bank_account.transactions.all :conditions => {:credit_type => CreditType::MONEY}
    @sms_transactions = current_user.bank_account.transactions.all :conditions => {:credit_type => CreditType::SMS_ALERT}

    render :layout => current_user_type
  end

  def new
    render :layout => current_user_type
  end

  def create
    if params[:transaction] and params[:transaction][:amount]
      current_user.bank_account.charge!(params[:transaction][:amount])
    end
    redirect_to self.send("#{current_user_type}_transactions_path"), :notice => "充值成功。"
  rescue NegativeNumberError
    flash[:error] = "请输入正数。"
    render :new, :layout => current_user_type
  end

  def withdraw
    render :layout => current_user_type
  end

  def buy
    render :layout => current_user_type
  end
end