class JobsController < ApplicationController
  def index
    @jobs = Job.paginate :all, :page => params[:page], :per_page => 20
  end

  def show
    @job = Job.find(params[:id])
  end
end