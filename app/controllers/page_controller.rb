class PageController < ApplicationController
  
  def partner_site_header
    render :layout => false
  end
  
  def partner_site_footer
    render :layout => false
  end
  
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
end
