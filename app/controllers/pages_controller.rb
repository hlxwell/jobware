class PagesController < ApplicationController

  def slideshowpro
    respond_to do |format|
      format.xml
    end
  end

  def term
    render :layout => false
  end
  
  def ad_service
  end
  
  def recruiter_service
  end
end
