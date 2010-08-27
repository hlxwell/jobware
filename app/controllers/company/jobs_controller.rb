class Company::JobsController < Company::BaseController

  def index
    @jobs = current_user.company.jobs.paginate :page => params[:page], :per_page => 1
  end

  def show
    @job = current_user.company.jobs.find(params[:id])
  end

  def new
    @job = current_user.company.jobs.new
  end

  def create
    @job = current_user.company.jobs.build(params[:job])
    if @job.save
      redirect_to company_job_path(@job), :notice => "岗位发布成功。"
    else
      render :action => 'new'
    end
  end

  def edit
    @job = current_user.company.jobs.find(params[:id])
  end

  def update
    @job = current_user.company.jobs.find(params[:id])
    if @job.update_attributes(params[:job])
      redirect_to company_job_path(@job), :notice => "岗位更新成功。"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @job = current_user.company.jobs.find(params[:id])
    @job.destroy
    flash[:notice] = "Successfully destroyed job."
    redirect_to company_jobs_path
  end
end
