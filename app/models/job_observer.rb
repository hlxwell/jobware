class JobObserver < ActiveRecord::Observer

  def after_create(job)
    # increase job count for referal partner
    job.partner.try(:increase_job)
    job.user.pay!(1, :service_item_id => ServiceItem.job_credit_id, :to => "发布岗位##{job.id}")
  end

  def before_update(job)
    job.reapprove if job.disapproved?
  end

end
