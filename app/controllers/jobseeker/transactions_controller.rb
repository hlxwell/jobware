class Jobseeker::TransactionsController < Jobseeker::BaseController
  def index
    @money_transactions = current_user.bank_account.transactions.all :conditions => {:credit_type => CreditType::MONEY}
    @sms_transactions = current_user.bank_account.transactions.all :conditions => {:credit_type => CreditType::SMS_ALERT}
  end

  def show
  end
  
  def new
  end

  def create
    if params[:transaction] and params[:transaction][:amount]
      current_user.bank_account.charge!(params[:transaction][:amount])
    end
    redirect_to jobseeker_transactions_path, :notice => "充值成功。"
  rescue NegativeNumberError
    flash[:error] = "请输入正数。"
    render :new
  end
end
