# -*- encoding : utf-8 -*-
class JobObserver < ActiveRecord::Observer

  def before_update(job)
    job.reapprove if job.rejected?
  end

end
