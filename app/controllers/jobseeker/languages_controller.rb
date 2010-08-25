class Jobseeker::LanguagesController < Jobseeker::BaseController
  def index
    @languages = Jobseeker::language.all
  end
  
  def show
    @language = Jobseeker::language.find(params[:id])
  end
  
  def new
    @language = Jobseeker::language.new
  end
  
  def create
    @language = Jobseeker::language.new(params[:language])
    if @language.save
      flash[:notice] = "Successfully created language."
      redirect_to @language
    else
      render :action => 'new'
    end
  end
  
  def edit
    @language = Jobseeker::language.find(params[:id])
  end
  
  def update
    @language = Jobseeker::language.find(params[:id])
    if @language.update_attributes(params[:language])
      flash[:notice] = "Successfully updated language."
      redirect_to @language
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @language = Jobseeker::language.find(params[:id])
    @language.destroy
    flash[:notice] = "Successfully destroyed language."
    redirect_to languages_url
  end
end
