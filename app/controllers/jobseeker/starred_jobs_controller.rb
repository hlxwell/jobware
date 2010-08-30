class Jobseeker::StarredJobsController < Jobseeker::BaseController
  def index
    @starred_jobs = current_user.jobseeker.starred_jobs.paginate :page => params[:page], :per_page => 20, :include => :job
  end
end