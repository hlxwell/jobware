class JobApplicationsController < ApplicationController
  before_filter :jobseeker_login_required

  def new
    @job_application = current_user.jobseeker.job_applications.build
    @job = Job.find(params[:job_id])
    respond_to do |format|
      format.html {redirect_to @job}
      format.js
    end
  end

  def create
    @job_application = current_user.jobseeker.job_applications.build(params[:job_application])
    if @job_application.save
      respond_to do |format|
        format.html {redirect_to @job}
        format.js
      end
    else
      render :action => 'new'
    end
  end
end