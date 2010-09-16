class ResumeObserver < ActiveRecord::Observer

  def after_create(resume)
    resume.partner.try(:increase_jobseeker)
  end

end
