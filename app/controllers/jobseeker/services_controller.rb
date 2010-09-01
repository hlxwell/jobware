class Jobseeker::ServicesController < Jobseeker::BaseController
  def index
    @services = Service.for_jobseeker
  end

  def show
  end

end
