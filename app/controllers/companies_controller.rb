class CompaniesController < ApplicationController
  respond_to :xml, :only => :presentations
  before_filter :redirect_to_new_job_if_login, :only => [:new, :create]
  before_filter :get_company_by_id, :only => [:show, :all_jobs, :presentations]
  before_filter :get_job_by_job_id, :only => [:show, :all_jobs, :presentations]

  def index
    @companies = Company.opened.with_theme(current_theme_site).paginate :all, :page => params[:page], :per_page => 10
  end

  def tag
    @companies = Company.opened.tagged_with(params[:tag]).paginate :all, :page => params[:page], :per_page => 10
    render :index
  end

  def show
    render :layout => "company_home_page"
  end

  def all_jobs
    @jobs = @company.jobs.opened
    render :layout => "company_home_page"
  end

  def presentations
    @presentations = @company.presentations
    render :layout => "company_home_page"
  end

  def new
    @company = Company.new
    @company.build_user
  end

  def create
    if params.get(:company, :tag_list)
      params[:company][:tag_list] = params[:company][:tag_list].gsub("，", ",")
    end
    @company = Company.new(params[:company])
    @company.user = current_user if current_user
    @company.partner = current_partner # referral partner

    if @company.save
      redirect_to created_companies_path
    else
      render :action => 'new'
    end
  end

  def created
  end

private
  def get_job_by_job_id
    @job = Job.opened.find(params[:job_id]) if params[:job_id]
  end

  def get_company_by_id
    @company = Company.find(params[:id])
  end

  def redirect_to_new_job_if_login
    redirect_to new_company_job_path if company_user?
  end
end