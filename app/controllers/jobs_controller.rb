class JobsController < ApplicationController
  before_filter :jobseeker_login_required, :only => :star
  before_filter :get_job_by_id, :only => [:show, :star]

  def index
    @jobs = Job.opened.with_theme(current_theme_site).order("keep_top desc, updated_at desc").paginate :all, :page => params[:page], :per_page => 10
    respond_to do |format|
      format.html
      format.atom
    end
  end

  def tag
    @jobs = Job.tagged_with(params[:tag]).opened.order("updated_at desc").paginate :all, :page => params[:page], :per_page => 10
    render :index
  end

  def show
    @starred_job = current_user.try(:jobseeker).present? ? current_user.jobseeker.starred_jobs.where(:job_id => params[:id]).first : nil
    render :layout => "company_home_page"
  end

  def star
    rating = params[:starred_job].present? ? params[:starred_job][:rating]||0 : 0
    @result = current_user.jobseeker.star_job(@job, rating.to_i)

    respond_to do |format|
      format.html { redirect_to @job }
      format.js
    end
  end

  def search
    @keywords = params[:search][:keywords]

    @jobs = Job.opened.with_theme(current_theme_site).search(params[:search][:keywords],
    :page => params[:page],
    :rank_mode  => :wordcount,
    :sort_mode  => :extended,
    :order => "keep_top DESC, @rank DESC, updated_at DESC",
    :per_page => 20,
    :match_mode => :extended,
    :field_weights => {
      :name => 6, :location => 5, :content => 5, :requirement => 2, :company_name => 2
    })

    render "index"
  end

  private

  def get_job_by_id
    @job = current_user.company.jobs.find_by_id(params[:id]) if current_user.try(:company)
    @job ||= Job.opened.find(params[:job_id] || params[:id])
  end
end