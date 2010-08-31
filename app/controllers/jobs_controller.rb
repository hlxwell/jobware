class JobsController < ApplicationController
  before_filter :jobseeker_login_required, :only => :star
  
  def index
    @jobs = Job.paginate :all, :page => params[:page], :per_page => 20
  end

  def show
    @job = Job.find(params[:id])
    @starred_job = current_user.try(:jobseeker).present? ? current_user.jobseeker.starred_jobs.where(:job_id => params[:id]).first : nil
  end

  def star
    @job = Job.find(params[:id])
    rating = params[:starred_job].present? ? params[:starred_job][:rating]||0 : 0
    @result = current_user.jobseeker.star_job(@job, rating.to_i)

    respond_to do |format|
      format.html { redirect_to @job }
      format.js
    end
  end
end