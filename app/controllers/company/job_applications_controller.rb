class Company::JobApplicationsController < Company::BaseController
  def index
    @applications = current_user.company.job_applications.paginate :page => params[:page], :per_page => 20, :include => [:job, :resume]
  end

  def show
    @application = current_user.company.job_applications.find(params[:id], :include => [:resume, :cover_letter, :job])
    @resume = @application.resume
    @cover_letter = @application.cover_letter
    @job = @application.job
  end

  def star
    @app = current_user.company.job_applications.find(params[:id])
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
