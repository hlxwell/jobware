class PageController < ApplicationController
  
  def company_benifit
  end
  
  def partner_benifit
  end
  
  def aboutus
  end
  
  def slideshowpro
    respond_to do |format|
      format.xml
    end
  end
end
