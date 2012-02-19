class CompaniesController < ApplicationController
  respond_to :xml, :only => :presentations
  before_filter :redirect_to_new_job_if_login, :only => [:new, :create]
  before_filter :get_company_by_id, :only => [:show, :all_jobs, :presentations]
  before_filter :get_job_by_job_id, :only => [:show, :all_jobs, :presentations]

  def index
    unless fragment_exist?(company_index_cache_key)
      @companies = Company.opened.with_theme(current_theme_site).paginate :all, :page => params[:page], :per_page => 15
    end
  end

  def filter
    unless fragment_exist?(company_filter_cache_key)
      @location     = params[:location]
      @size         = params[:size]
      @company_type = params[:company_type]
      @industry     = params[:industry]

      @company_type_name = CompanyType.to_a.select{|i| i.last.to_s == @company_type}.flatten.first
      @industry_name = CompanyIndustry.to_a.select{|i| i.last.to_s == @industry}.flatten.first

      @search_query = Company.opened.with_theme(current_theme_site)
      @search_query = @search_query.where(["province=? or city=?", @location, @location]) unless @location.blank?
      @search_query = @search_query.where(["size LIKE ?", "%#{@size}%"]) unless @size.blank?
      @search_query = @search_query.where(["company_type=?", @company_type]) unless @company_type.blank?
      @search_query = @search_query.where(["industry=?", @industry]) unless @industry.blank?

      @companies = @search_query.paginate :all, :page => params[:page], :per_page => 15

      @title = "#{@location}#{@industry_name}#{@company_type_name}企业"
    end
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
    @company.themes = current_theme_site

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