class Company::JobApplicationsController < Company::BaseController
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
    @app = current_user.company.job_applications.find(params[:id], :readonly => false)
    rating = params[:job_application].present? ? params[:job_application][:rating] : 0

    if @app.update_attribute :rating, rating
      @result = rating == 0 ? "取消成功" : "收藏成功"
    else
      @result = "收藏失败"
    end

    respond_to do |format|
      format.html { redirect_to company_job_applications_path }
      format.js
    end
  end

end
