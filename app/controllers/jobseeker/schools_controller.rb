class Jobseeker::SchoolsController < Jobseeker::BaseController
  def index
    @schools = Jobseeker::school.all
  end
  
  def show
    @school = Jobseeker::school.find(params[:id])
  end
  
  def new
    @school = Jobseeker::school.new
  end
  
  def create
    @school = Jobseeker::school.new(params[:school])
    if @school.save
      flash[:notice] = "Successfully created school."
      redirect_to @school
    else
      render :action => 'new'
    end
  end
  
  def edit
    @school = Jobseeker::school.find(params[:id])
  end
  
  def update
    @school = Jobseeker::school.find(params[:id])
    if @school.update_attributes(params[:school])
      flash[:notice] = "Successfully updated school."
      redirect_to @school
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @school = Jobseeker::school.find(params[:id])
    @school.destroy
    flash[:notice] = "Successfully destroyed school."
    redirect_to schools_url
  end
end
