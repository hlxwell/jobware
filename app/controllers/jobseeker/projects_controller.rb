class Jobseeker::ProjectsController < Jobseeker::BaseController
  def index
    @projects = Jobseeker::project.all
  end
  
  def show
    @project = Jobseeker::project.find(params[:id])
  end
  
  def new
    @project = Jobseeker::project.new
  end
  
  def create
    @project = Jobseeker::project.new(params[:project])
    if @project.save
      flash[:notice] = "Successfully created project."
      redirect_to @project
    else
      render :action => 'new'
    end
  end
  
  def edit
    @project = Jobseeker::project.find(params[:id])
  end
  
  def update
    @project = Jobseeker::project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = "Successfully updated project."
      redirect_to @project
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @project = Jobseeker::project.find(params[:id])
    @project.destroy
    flash[:notice] = "Successfully destroyed project."
    redirect_to projects_url
  end
end
