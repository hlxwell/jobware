class Jobseeker::ResumesController < Jobseeker::BaseController
  before_filter :no_jobseeker_login_required, :only => [:new, :new_with_choices, :create]
  before_filter :jobseeker_login_required, :except => [:new,:new_with_choices, :create, :created]
  before_filter :get_resume, :only => [:show, :edit, :update]

  def new
    @resume = Resume.new
    @resume.build_user
    @resume.cover_letters.build
    render :layout => current_layout
  end

  def new_with_choices
    render :layout => current_layout
  end

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

  def create
    @resume = Resume.new(params[:resume])
    @resume.user = current_user if current_user
    @resume.partner = current_partner

    if @resume.save
      continue_apply_job_id = session[:continue_apply_job_id]
      session[:continue_apply_job_id] = nil

      # if knows the job id, send one job application.
      if continue_apply_job_id.present? and Job.find_by_id(continue_apply_job_id)
        @job_application = @resume.job_applications.build( :job_id => continue_apply_job_id, :cover_letter_id => @resume.cover_letters.first)
        @job_application.partner = current_partner

        if @job_application.save
          redirect_to job_path(continue_apply_job_id), :notice => "您已应聘成功该岗位，请检查您的邮箱激活您的登录帐号。"
        else
          redirect_to job_path(continue_apply_job_id), :notice => "简历创建成功，请检查您的邮箱激活您的登录帐号，然后再继续应聘。"
        end
      else
        redirect_to created_jobseeker_resume_path
      end
    else
      render :action => 'new', :layout => current_layout
    end
  end

  def created
    render :layout => current_layout
  end

  private

  def get_resume
    @resume = current_user.jobseeker
  end
end
