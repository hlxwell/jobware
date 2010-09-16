class CompaniesController < ApplicationController
  respond_to :xml, :only => :presentations
  before_filter :redirect_to_new_job_if_login, :only => [:new, :create]

  def index
    @companies = Company.paginate :all, :page => params[:page], :per_page => 20
  end

  def show
    @company = Company.find(params[:id])
  end

  def presentations
    @company = Company.find(params[:id])
    @presentations = @company.presentations
    respond_with @presentations
  end

  def new
    @company = Company.new
    @company.build_user
    @company.jobs.build
  end

  def create
    @company = Company.new(params[:company])
    @company.user = current_user if current_user
    @company.partner = current_partner

    if @company.save
      redirect_to company_job_path(@company.jobs.first), :notice => "岗位创建成功。"
    else
      render :action => 'new'
    end
  end

private

  def redirect_to_new_job_if_login
    redirect_to new_company_job_path if company_user?
  end
end