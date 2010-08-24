class ResumeController < ApplicationController
  def index
    @resumes = Resume.all
  end
  
  def show
    @resume = Resume.find(params[:id])
  end
  
  def new
    @resume = Resume.new
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
  
  def destroy
    @resume = Resume.find(params[:id])
    @resume.destroy
    flash[:notice] = "Successfully destroyed resume."
    redirect_to resumes_url
  end
end
