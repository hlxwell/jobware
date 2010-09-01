class Company::ServicesController < Company::BaseController
  def index
    @services = Service.for_company
  end

  def show
  end

end
