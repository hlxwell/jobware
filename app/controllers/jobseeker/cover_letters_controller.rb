class Jobseeker::CoverLettersController < Jobseeker::BaseController
  def index
    @cover_letters = Jobseeker::coverLetter.all
  end
  
  def show
    @cover_letter = Jobseeker::coverLetter.find(params[:id])
  end
  
  def new
    @cover_letter = Jobseeker::coverLetter.new
  end
  
  def create
    @cover_letter = Jobseeker::coverLetter.new(params[:cover_letter])
    if @cover_letter.save
      flash[:notice] = "Successfully created cover letter."
      redirect_to @cover_letter
    else
      render :action => 'new'
    end
  end
  
  def edit
    @cover_letter = Jobseeker::coverLetter.find(params[:id])
  end
  
  def update
    @cover_letter = Jobseeker::coverLetter.find(params[:id])
    if @cover_letter.update_attributes(params[:cover_letter])
      flash[:notice] = "Successfully updated cover letter."
      redirect_to @cover_letter
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @cover_letter = Jobseeker::coverLetter.find(params[:id])
    @cover_letter.destroy
    flash[:notice] = "Successfully destroyed cover letter."
    redirect_to cover_letters_url
  end
end
