class Jobseeker::CertificationsController < Jobseeker::BaseController
  def index
    @certifications = Jobseeker::certification.all
  end
  
  def show
    @certification = Jobseeker::certification.find(params[:id])
  end
  
  def new
    @certification = Jobseeker::certification.new
  end
  
  def create
    @certification = Jobseeker::certification.new(params[:certification])
    if @certification.save
      flash[:notice] = "Successfully created certification."
      redirect_to @certification
    else
      render :action => 'new'
    end
  end
  
  def edit
    @certification = Jobseeker::certification.find(params[:id])
  end
  
  def update
    @certification = Jobseeker::certification.find(params[:id])
    if @certification.update_attributes(params[:certification])
      flash[:notice] = "Successfully updated certification."
      redirect_to @certification
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @certification = Jobseeker::certification.find(params[:id])
    @certification.destroy
    flash[:notice] = "Successfully destroyed certification."
    redirect_to certifications_url
  end
end
