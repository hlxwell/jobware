class Company::JobsController < Company::BaseController
  before_filter :get_job_by_id, :only => [:show, :edit, :update, :destroy, :close, :open, :reactive]
  before_filter :check_job_credit, :only => [:new, :create, :reactive]
  before_filter :check_job_highlight_credit, :only => [:reactive, :open]
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
    @job.partner = current_partner

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
      # need to reapprove after job info was updated.
      @job.reapprove
      redirect_to company_job_path(@job), :notice => "岗位更新成功。"
    else
      render :action => 'edit'
    end
  end

  def destroy
    if @job.destroy
      flash[:success] = "删除岗位成功。"
    else
      flash[:error] = "删除岗位失败。"
    end
    redirect_to company_jobs_path
  end

  def open
    if @job.active
      flash[:success] = "岗位打开成功。"
    else
      flash[:error] = "岗位打开失败。"
    end
    redirect_to company_jobs_path
  end

  def close
    if @job.close
      flash[:success] = "岗位关闭成功。"
    else
      flash[:error] = "岗位关闭失败。"
    end
    redirect_to company_jobs_path
  end

  def reactive
    if @job.active
      flash[:success] = "扣除一点“岗位发布”,岗位重新激活成功。"
    else
      flash[:error] = "岗位重新激活失败，可能没有足够“岗位发布”点数。"
    end
    redirect_to company_jobs_path
  end

private

  def get_job_by_id
    @job = current_user.company.jobs.find(params[:id])
  end

  def check_job_credit
    redirect_to company_jobs_path, :notice => "没有足够的岗位发布点数，请购买后再发布。" if current_user.remains(ServiceItem.job_credit_id) <= 0
  end

  def check_job_highlight_credit
    redirect_to company_jobs_path, :notice => "没有足够的岗位高亮显示点数，请购买后再发布，或者取消岗位高亮显示。" if @job.highlighted? and current_user.remains(ServiceItem.job_highlight_credit_id) <= 0
  end
end