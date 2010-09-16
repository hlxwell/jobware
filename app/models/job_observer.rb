class JobObserver < ActiveRecord::Observer

  def after_create(job)
    job.partner.try(:increase_job)
  end

end
