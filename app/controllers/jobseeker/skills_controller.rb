class Jobseeker::SkillsController < Jobseeker::BaseController
  def index
    @skills = Jobseeker::skill.all
  end
  
  def show
    @skill = Jobseeker::skill.find(params[:id])
  end
  
  def new
    @skill = Jobseeker::skill.new
  end
  
  def create
    @skill = Jobseeker::skill.new(params[:skill])
    if @skill.save
      flash[:notice] = "Successfully created skill."
      redirect_to @skill
    else
      render :action => 'new'
    end
  end
  
  def edit
    @skill = Jobseeker::skill.find(params[:id])
  end
  
  def update
    @skill = Jobseeker::skill.find(params[:id])
    if @skill.update_attributes(params[:skill])
      flash[:notice] = "Successfully updated skill."
      redirect_to @skill
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @skill = Jobseeker::skill.find(params[:id])
    @skill.destroy
    flash[:notice] = "Successfully destroyed skill."
    redirect_to skills_url
  end
end
