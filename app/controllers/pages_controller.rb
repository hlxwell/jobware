class PagesController < ApplicationController

  def company_benifit
  end

  def partner_benifit
  end

  def aboutus
  end

  def services
  end

  def contactus
  end

  def slideshowpro
    respond_to do |format|
      format.xml
    end
  end
  
  def not_found
    
  end
  
  def internal_error
  end
end
