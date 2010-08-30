class Jobseeker::JobApplicationsController < Jobseeker::BaseController
  def index
    @applications = current_user.jobseeker.job_applications.paginate :page => params[:page], :per_page => 20, :include => :job
  end

end
