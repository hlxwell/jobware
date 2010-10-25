class JobApplicationObserver < ActiveRecord::Observer
  def after_create(job_app)
    job_app.partner.try(:increase_job_application)
    CompanyMailer.delay.new_applicant(job_app.job.company, job_app)
  end

  def after_update(job_app)
    # send mail to job seeker tell him that his app been starred.
    if job_app.rating_changed? and
      job_app.rating_change.first.nil? and
      !job_app.rating_change.last.nil? and
      job_app.rating_change.last > 0

      JobseekerMailer.delay.app_been_starred(job_app.resume, job_app)
    end
  end
end