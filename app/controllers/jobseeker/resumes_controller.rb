class Jobseeker::ResumesController < Jobseeker::BaseController
  before_filter :no_jobseeker_login_required, :only => [:new, :create]
  before_filter :jobseeker_login_required, :except => [:new, :create]
  before_filter :get_resume, :only => [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @resume.update_attributes(params[:resume])
      redirect_to jobseeker_resume_path, :notice => "简历更新成功。"
    else
      render :action => 'edit'
    end
  end

  #### signup
  def new
    @resume = Resume.new
    @resume.build_user
    ["languages", "previous_jobs", "certifications", "cover_letters", "projects", "schools", "skills"].each do |association|
      @resume.send("#{association}").build
    end
    render :layout => "application"
  end

  def create
    @resume = Resume.new(params[:resume])
    if @resume.save
      redirect_to jobseeker_dashboard_path, :notice => "简历创建成功。"
    else
      render :action => 'new', :layout => "application"
    end
  end

  private

  def get_resume
    @resume = current_user.jobseeker
  end
end
