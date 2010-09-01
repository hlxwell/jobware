class CompaniesController < ApplicationController
  respond_to :xml, :only => :presentations

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

    if @company.save
      redirect_to company_job_path(@company.jobs.first), :notice => "岗位创建成功。"
    else
      render :action => 'new'
    end
  end
end