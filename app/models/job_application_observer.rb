class JobApplicationObserver < ActiveRecord::Observer
  def after_create(job_app)
    job_app.partner.try(:increase_job_application) 
  end
end
