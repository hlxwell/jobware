class JobsController < ApplicationController
  before_filter :jobseeker_login_required, :only => :star

  def index
    @jobs = Job.opened.order("updated_at desc").paginate :all, :page => params[:page], :per_page => 20

    respond_to do |format|
      format.atom
      format.html
    end
  end

  def show
    @job = Job.opened.find(params[:id])
    @starred_job = current_user.try(:jobseeker).present? ? current_user.jobseeker.starred_jobs.where(:job_id => params[:id]).first : nil
  end

  def star
    @job = Job.opened.find(params[:id])
    rating = params[:starred_job].present? ? params[:starred_job][:rating]||0 : 0
    @result = current_user.jobseeker.star_job(@job, rating.to_i)

    respond_to do |format|
      format.html { redirect_to @job }
      format.js
    end
  end

  def search
    @jobs = Job.opened.search(params[:search][:keywords],
    :page => params[:page],
    :rank_mode  => :wordcount,
    :sort_mode  => :extended,
    :order => "@rank DESC, created_at DESC",
    :per_page => 20,
    :match_mode => :extended,
    :field_weights => {
      :name => 6, :location => 5, :content => 5, :requirement => 2, :company_name => 2
    })

    render "index"
  end
end