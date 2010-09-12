module TransactionsControllerBase

  def index
    render "transactions/index", :layout => current_user_section and return if params[:service_item_id].blank? and !request.xhr?

    @transactions = current_user.transactions.where(:service_item_id => params[:service_item_id]).all
    render :partial => "transactions/list"
  end

  ### charge
  def new
    render "transactions/new", :layout => current_user_section
  end

  def create
    if params[:transaction] and params[:transaction][:amount]
      operation = params[:transaction][:operation] || 'charge!'
      current_user.send(operation, params[:transaction][:amount])
      flash[:notice] = "操作成功。"
    else
      flash[:notice] = "操作失败。"
    end

    redirect_to self.send("#{current_user_section}_transactions_path")
  rescue NegativeNumberError
    flash[:error] = "请输入正数。"
    render "transactions/new", :layout => current_user_section
  end

  def withdraw
    render "transactions/withdraw", :layout => current_user_section
  end

end