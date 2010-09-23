class AdObserver < ActiveRecord::Observer
  def before_update(ad)
    ad.reapprove if ad.rejected?
  end
end
