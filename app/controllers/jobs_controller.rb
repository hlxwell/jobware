class JobsController < ApplicationController
  before_filter :jobseeker_login_required, :only => :star
  before_filter :get_job_by_id, :only => [:show, :star]

  def index
    @jobs = Job.opened.with_theme(current_theme_site).order("keep_top desc, start_at desc").paginate :all, :page => params[:page], :per_page => params[:limit]||15

    respond_to do |format|
      format.html
      format.atom
      format.xml
    end
  end

  def show
    @starred_job = current_user.try(:jobseeker).present? ? current_user.jobseeker.starred_jobs.where(:job_id => params[:id]).first : nil

    respond_to do |format|
      format.html {render :layout => "company_home_page"}
      format.ubb
      format.text
      format.bbshtml
    end
  end

  def star
    rating = params[:starred_job].present? ? params[:starred_job][:rating]||0 : 0
    @result = current_user.jobseeker.star_job(@job, rating.to_i)

    respond_to do |format|
      format.html { redirect_to @job }
      format.js
    end
  end

  def filter
    @location      = params[:location]
    @tool          = params[:tool]
    @category      = params[:category]
    @industry      = params[:industry]
    @salary_range  = params[:salary_range]
    @dateline      = params[:dateline]
    @contract_type = params[:contract_type]

    @category_name = JobCategory.to_a.select{|i| i.last.to_s == @category}.flatten.first
    @contract_type_name = ContractType.to_a.select{|i| i.last.to_s == @contract_type}.flatten.first

    @search_query  = Job.opened.with_theme(current_theme_site).joins(:company).desc
    @search_query  = @search_query.where(["location_province=? or location_city=?", @location, @location]) unless @location.blank?
    @search_query  = @search_query.where(["jobs.name LIKE ?", "%#{@tool}%"]) unless @tool.blank?
    @search_query  = @search_query.where(["jobs.category=?", @category]) unless @category.blank?
    @search_query  = @search_query.where(["companies.industry=?", @industry]) unless @industry.blank?
    @search_query  = @search_query.where(["salary_range=?", @salary_range]) unless @salary_range.blank?
    @search_query  = @search_query.where(["contract_type=?", @contract_type]) unless @contract_type.blank?
    @search_query  = @search_query.where(["start_at between ? and ?", @dateline.to_i.days.ago, Time.now]) unless @dateline.blank?

    @jobs = @search_query.paginate :all, :page => params[:page], :per_page => 15

    @title = "#{@location} #{@contract_type_name} #{@tool} #{@category_name}"

    render :index
  end

  def search
    @keyword = params[:keyword] || params.get(:search, :keyword) || ""
    @keyword.gsub!("/", "\/")
    @keyword.gsub!("[--=<>]+", "")

    @jobs = Job.opened.with_theme(current_theme_site).search(
      @keyword,
      :page => params[:page],
      :rank_mode  => :wordcount,
      :sort_mode  => :extended,
      :order => "keep_top DESC, @rank DESC, updated_at DESC",
      :per_page => 20,
      :match_mode => :extended,
      :field_weights => {
        :name => 6, :location => 5, :content => 5, :requirement => 2, :company_name => 2
      }
    )
    # :conditions => {:theme => current_theme_site})

    render "index"
  end

  private

  def get_job_by_id
    @job = current_user.company.jobs.find_by_id(params[:id]) if current_user.try(:company)
    @job ||= Job.opened.find(params[:job_id] || params[:id])
  end
end