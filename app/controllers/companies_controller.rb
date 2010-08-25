class CompaniesController < ApplicationController  
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
    @company.build_user
  end

  def create
    @company = Company.new(params[:company])
    @company.build_user(params[:company][:user_attributes])

    if @company.save
      flash[:notice] = "公司创建成功。"
      redirect_to "/"
    else
      render :action => 'new'
    end
  end
end