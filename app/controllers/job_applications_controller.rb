class JobApplicationsController < ApplicationController
  before_filter :redirect_to_new_resume_page_if_not_jobseeker, :get_job_by_job_id

  def new
    @job_application = current_user.jobseeker.job_applications.build
    @job_application.build_cover_letter
    respond_to do |format|
      format.html {redirect_to @job}
      format.js
    end
  end

  def create
    @job_application = current_user.jobseeker.job_applications.build(params[:job_application])
    @job_application.partner = current_partner

    if @job_application.save
      respond_to do |format|
        format.html {redirect_to @job}
        format.js
      end
    else
      @job_application.build_cover_letter if @job_application.cover_letter.blank?
      render :action => 'new'
    end
  end

private

  def get_job_by_job_id
    @job = Job.find(params[:job_id])
  end

  def redirect_to_new_resume_page_if_not_jobseeker
    unless jobseeker_user?
      session[:continue_apply_job_id] = params[:job_id]
      respond_to do |format|
        format.html {redirect_to new_jobseeker_resume_path(:choose => true)}
        format.js {render :text => "$(location).attr('href', '#{new_jobseeker_resume_path(:choose => true)}');"}
      end
    end
  end
end