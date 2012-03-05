# -*- encoding : utf-8 -*-
module ServicesControllerBase
  def index
    @services = current_user_section != 'partner' ? Service.send("for_#{current_user_section}") : []
    
    @set_services = @services.map {|service| service if service.service_items.count > 1 }.compact
    @single_services = @services.map {|service| service if service.service_items.count <= 1 }.compact
    render "services/index", :layout => current_user_section
  end

  def bought
    @transactions = current_user.transactions_for_buying_service
    render "services/bought", :layout => current_user_section
  end

  def show
    @service = Service.find(params[:id])
    render "services/show", :layout => current_user_section
  end

  def buy
    @service = Service.find(params[:id])
    @service.buy_from!(current_user)
    redirect_to send("bought_#{current_user_section}_services_path")
  rescue CreditNotEnoughError
    flash[:error] = "帐户里没有足够现金，请充值。"
    redirect_to :back
  end
end
