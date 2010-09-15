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
  # ["languages", "previous_jobs", "certifications", "cover_letters", "projects", "schools", "skills"].each do |association|
  #   @resume.send("#{association}").build
  # end
  def new
    @resume = Resume.new
    @resume.build_user
    @resume.cover_letters.build

    render (params[:choose].present? ? "new_with_choices" : "new"), :layout => current_layout
  end

  def create
    # TODO send password to user and make a random password.
    if params[:resume][:quick_resume] == 'true' and params[:resume][:user_attributes].present?
      random_password = "123321"
      params[:resume][:user_attributes].update(:password => random_password, :password_confirmation => random_password)
    end

    @resume = Resume.new(params[:resume])
    @resume.user = current_user if current_user

    if @resume.save
      # if knows the job id, send one job application.
      if session[:continue_apply_job_id].present? and Job.find_by_id(session[:continue_apply_job_id])
        @job_application = @resume.job_applications.build( :job_id => session[:continue_apply_job_id], :cover_letter_id => @resume.cover_letters.first, :partner_site_id => current_partner_site.try(:id) )

        if @job_application.save
          redirect_to job_path(session[:continue_apply_job_id]), :notice => "您已应聘成功。"
        else
          redirect_to job_path(session[:continue_apply_job_id]), :notice => "简历创建成功，您可以继续应聘。"
        end

        # clear continue_apply_job_id
        session[:continue_apply_job_id] = nil
      else
        redirect_to jobseeker_dashboard_path, :notice => "简历创建成功。"
      end
    else
      if @resume.quick_resume == 'true'
        render :action => 'new_with_choices', :layout => current_layout
      else
        render :action => 'new', :layout => current_layout
      end
    end
  end

  private

  def get_resume
    @resume = current_user.jobseeker
  end
end
