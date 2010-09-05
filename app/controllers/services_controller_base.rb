module ServicesControllerBase
  def index
    @services = current_user_type != 'partner' ? Service.send("for_#{current_user_type}") : []
    render "services/index", :layout => current_user_type
  end
  
  def bought
    @transactions = current_user.bank_account.transactions_for_buying_service
    render "services/bought", :layout => current_user_type
  end

  def show
    render "services/show", :layout => current_user_type
  end

  def buy
    service = Service.find(params[:id])
    service.buy_from!(current_user)
    redirect_to send("bought_#{current_user_type}_services_path")
  rescue CreditNotEnoughError
    flash[:error] = "帐户里没有足够现金。"
    redirect_to "/#{current_user_type}/services"
  end
end