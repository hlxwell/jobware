class Jobseeker::PreviousJobsController < Jobseeker::BaseController
  def index
    @previous_jobs = Jobseeker::previousJob.all
  end
  
  def show
    @previous_job = Jobseeker::previousJob.find(params[:id])
  end
  
  def new
    @previous_job = Jobseeker::previousJob.new
  end
  
  def create
    @previous_job = Jobseeker::previousJob.new(params[:previous_job])
    if @previous_job.save
      flash[:notice] = "Successfully created previous job."
      redirect_to @previous_job
    else
      render :action => 'new'
    end
  end
  
  def edit
    @previous_job = Jobseeker::previousJob.find(params[:id])
  end
  
  def update
    @previous_job = Jobseeker::previousJob.find(params[:id])
    if @previous_job.update_attributes(params[:previous_job])
      flash[:notice] = "Successfully updated previous job."
      redirect_to @previous_job
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @previous_job = Jobseeker::previousJob.find(params[:id])
    @previous_job.destroy
    flash[:notice] = "Successfully destroyed previous job."
    redirect_to previous_jobs_url
  end
end
