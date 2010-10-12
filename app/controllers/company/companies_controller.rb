class Company::CompaniesController < Company::BaseController

  def show
    @company = current_user.company
  end

  def edit
    @company = current_user.company
    # @company.products.build if @company.products.count == 0
    # @company.presentations.build if @company.presentations.count == 0
  end

  def update
    @company = current_user.company
    @company.permalink = nil ### regenerate the url permalink.
    if @company.update_attributes(params[:company])
      redirect_to company_company_path, :notice => "公司信息更新成功。"
    else
      render :action => 'edit'
    end
  end

end
