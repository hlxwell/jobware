class Company::JobsController < Company::BaseController
  before_filter :get_job_by_id, :only => [:show, :edit, :update, :destroy]

  def index
    @jobs = current_user.company.jobs.paginate :page => params[:page], :per_page => 20
  end

  def show
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
  end

  def update
    if @job.update_attributes(params[:job])
      redirect_to company_job_path(@job), :notice => "岗位更新成功。"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @job.destroy
    flash[:success] = "删除岗位成功。"
    redirect_to company_jobs_path
  end

private

  def get_job_by_id
    @job = current_user.company.jobs.find(params[:id])
  end
end
