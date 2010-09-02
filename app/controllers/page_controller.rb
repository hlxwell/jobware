class PageController < ApplicationController
  def aboutus
  end
  
  def slideshowpro
    respond_to do |format|
      format.xml
    end
  end
end
