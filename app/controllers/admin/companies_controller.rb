# Controller generated by Typus, use it to extend admin functionality.
class Admin::CompaniesController < Admin::ResourcesController
  def add_to_famous_company
    @ad = get_object.ads.famous_companies.first
    @ad ||= get_object.ads.build(
      :display_type => AdPositionType::FAMOUS_COMPANY,
      :period => 4
    )

    if @ad.save
      @ad.approve!
      flash[:notice] = "加入成功。"
    else
      flash[:notice] = @ad.errors.inspect
    end

    redirect_to :back
  end

  def add_to_featured_company
    @ad = get_object.ads.build(
      :name => get_object.name,
      :url => company_path(get_object),
      :display_type => AdPositionType::FEATURED_COMPANY,
      :image => get_object.logo,
      :period => 4
    )

    if @ad.save
      @ad.approve!
      flash[:notice] = "加入成功。"
    else
      flash[:notice] = @ad.errors.inspect
    end

    redirect_to :back
  end

  def change_email
    @company = get_object
    if params[:company][:new_email]
      @company.reset_email_and_send_reset_password_mail(params[:company][:new_email])
      flash[:notice] = "邮箱修改成功。"
    else
      flash[:notice] = "请输入需要修改的邮箱。"
    end
    redirect_to :action => :edit, :id => @company
  rescue Exception => e
    flash[:notice] = e.to_s
    redirect_to :action => :edit, :id => @company
  end

  def theme
    @companies = Company.paginate :all, :page => params[:page], :per_page => 30
  end

  def update_themes
    edited_ids = params[:company_ids].try(:keys) ||[]
    non_themes_ids = params[:ids] - edited_ids

    if params[:company_ids]
      flash[:notice] = "Update successfully。"
      params[:company_ids].each do |company_id, themes|
        Company.update_all(["themes=?", themes.uniq.join(",")], ["id=?", company_id])
      end
    end

    # clean cancelled themes
    Company.update_all(["themes=?", ""], ["id in (?)", non_themes_ids])

    redirect_to :action => :theme, :page => params[:page]
  end
end
