class Company::JobApplicationsController < Company::BaseController
  before_filter :get_job_app_by_id, :only => [:accept, :reject, :show, :star]

  def index
    scope_name = ["unread", "starred"].include?(params[:filter]) ? params[:filter] : "all"
    @applications = current_user.company.job_applications.send(scope_name).paginate :page => params[:page], :per_page => 20, :include => [:job, :resume]
  end

  def show
    @application = current_user.company.job_applications.find(params[:id], :include => [:resume, :cover_letter, :job], :readonly => false)
    @application.view

    ### update the new_job_application_count
    @new_job_application_count = current_user.company.job_applications.unread.count

    @resume       = @application.resume
    @cover_letter = @application.cover_letter
    @job          = @application.job
  end

  def star
    rating = params[:job_application].present? ? params[:job_application][:rating] : 0

    if @application.update_attribute :rating, rating
      @result = (rating == 0 ? "取消成功" : "收藏成功")
    else
      @result = "收藏失败"
    end

    respond_to do |format|
      format.html { redirect_to company_job_applications_path }
      format.js
    end
  end

  def accept
    if @application.accept
      redirect_to :back, :notice => "接受该简历成功，已发送邮件通知该应聘者，最好能再通过电话联系确认通知送达。"
    else
      redirect_to :back, :notice => "不能接受已接受的简历。"
    end
  end

  def reject
    if @application.reject
      redirect_to :back, :notice => "该简历已被拒绝，已发送了邮件通知该应聘者。"
    else
      redirect_to :back, :notice => "不能拒绝已被拒绝的简历。"
    end
  end

private

  def get_job_app_by_id
    @application = current_user.company.job_applications.find(params[:id], :readonly => false)
  end
end
