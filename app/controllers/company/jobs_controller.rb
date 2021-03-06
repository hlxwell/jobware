# -*- encoding : utf-8 -*-
class Company::JobsController < Company::BaseController
  before_filter :get_job_by_id, :only => [:show, :edit, :update, :destroy, :close, :open, :reactive, :get_options, :want_to_show]
  before_filter :check_job_credit, :only => [:reactive]
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
    @job.themes = current_theme_site

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
      # @job.reapprove
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
    if @job.open
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
    @extra_points_needed = ""
    @extra_points_needed << "，高亮点数" if @job.highlighted?
    @extra_points_needed << "，置顶点数" if @job.keep_top?

    if @job.active
      flash[:success] = "扣除一点“岗位发布”，岗位重新激活成功。"
    else
      flash[:error] = "岗位重新激活失败，可能没有足够“岗位发布”点数#{@extra_points_needed}。"
    end
    redirect_to company_jobs_path
  rescue CreditNotEnoughError
    flash[:error] = "岗位重新激活失败，可能没有足够“岗位发布”点数#{@extra_points_needed}。"
    redirect_to company_jobs_path
  end

  def get_options
    raise 'wrong option type.' unless ['welfare', 'question'].include?(params[:type])
    @options = @job.send("#{params[:type]}_options").map {|option| [option.name, option.desc]}
    render :json => @options
  end

  def want_to_show
    if @job.want_to_show
      flash[:success] = "扣除一点“岗位发布”成功，岗位正在审核中，如果审核通过则会显示在前台。"
    else
      flash[:error] = "扣除一点“岗位发布”失败，请充值后再激活。"
    end
  rescue CreditNotEnoughError => e
    flash[:error] = "扣除一点“岗位发布”失败，请充值后再激活。"
  ensure
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
