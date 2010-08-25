class Jobseeker::ResumesController < Jobseeker::BaseController
  before_filter :jobseeker_login_required, :except => [:new, :create]

  def show
    @resume = Resume.find(params[:id])
  end

  def edit
    @resume = Resume.find(params[:id])
  end

  def update
    @resume = Resume.find(params[:id])
    if @resume.update_attributes(params[:resume])
      flash[:notice] = "Successfully updated resume."
      redirect_to @resume
    else
      render :action => 'edit'
    end
  end

  #### signup
  def new
    @resume = Resume.new
    render :layout => "application"
  end

  def create
    @resume = Resume.new(params[:resume])
    if @resume.save
      flash[:notice] = "Successfully created resume."
      redirect_to @resume
    else
      render :action => 'new'
    end
  end
end
