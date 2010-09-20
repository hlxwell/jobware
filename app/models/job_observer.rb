class JobObserver < ActiveRecord::Observer

  def after_create(job)
    job.partner.try(:increase_job)
  end

  def before_update(job)
    job.reapprove if job.disapproved?
  end

end
