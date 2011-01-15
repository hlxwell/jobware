class AdsController < ApplicationController

  def index
  end

  def inline_widget
    @jobs = Job.limit(10).opened.with_theme(current_theme_site).order("keep_top desc, updated_at desc")
    @jobs.shuffle!
    render :layout => false
  end
end