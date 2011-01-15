# Controller generated by Typus, use it to extend admin functionality.
require 'nokogiri'

class Admin::JobsController < Admin::ResourcesController
  def new
    filtered_jobs = StagingJob
    filtered_jobs = filtered_jobs.where("name like '%#{params.get(:filter, :job_name)}%'") if params.get(:filter, :job_name).present?
    filtered_jobs = filtered_jobs.where("company_name like '%#{params.get(:filter, :company_name)}%'") if params.get(:filter, :company_name).present?
    @staging_jobs = filtered_jobs.paginate :all, :page => params[:page], :per_page => 30
  end

  def add_to_urgent_ad
    @ad = get_object.company.ads.build(
      :name => get_object.name,
      :url => job_path(get_object),
      :display_type => AdPositionType::URGENT_JOB,
      :province => get_object.location_province,
      :city => get_object.location_city,
      :period => 4,
      :themes => get_object.themes
    )

    if @ad.save
      @ad.approve!
      flash[:notice] = "加入成功。"
    else
      flash[:notice] = @ad.errors.inspect
    end

    redirect_to :back
  end

  def import
    @staging_job = StagingJob.find_by_id(params[:id]) || StagingJob.new
    @company = Company.where(:name => CGI::unescapeHTML(@staging_job.company_name)).first
    @is_company_exist = @company.present?

    if request.get?
      if @is_company_exist
        @job = @company.jobs.new
      else
        @company = Company.new
        @company.build_user
        @company.jobs.build
      end
    elsif request.post?
      # only add a new job to exist company
      if @is_company_exist
        @job = Job.new(params[:job])
        if @job.save
          # charge money.
          @company.user.charge! 100, :from => '手动添加'
          # buy post job service.
          Service.find(8).buy_from!(@company.user)
          # active the job.
          @job.want_to_show
          @job.set_random_views_count
          @staging_job.update_attribute :state, "published" if @staging_job.persisted?

          flash[:notice] = "工作创建成功。"
          redirect_to "/admin/users/edit/#{@company.user.id}"
          return
        end
      else # create a company and job
        @company = Company.new(params[:company])
        if @company.save
          # active user.
          @company.user.confirm!
          # charge money.
          @company.user.charge! 100, :from => '手动添加'
          # buy post job service.
          Service.find(8).buy_from!(@company.user)
          # active the job.
          @company.jobs.first.want_to_show
          @company.jobs.first.set_random_views_count
          @company.set_random_views_count

          @staging_job.update_attribute :state, "published" if @staging_job.persisted?

          flash[:notice] = "公司和岗位创建成功。"
          redirect_to "/admin/users/edit/#{@company.user.id}"
          return
        end
      end
    end

    render :layout => "simple"
  end

  def upload_xml
    if file = params.get(:xml, :file)
      @unsaved_jobs = []
      @saved_jobs = []
      doc = Nokogiri::XML(file.read)
      doc.xpath("//Content").find_all { |n|
        d = Nokogiri::XML(n.to_s)
        unless staging_job = StagingJob.where(:page_url => d.xpath("//PageUrl").children.to_s).count > 0
          staging_job = StagingJob.new({
            :origin_id             => (d.xpath("//ID").children.to_s).html_safe,
            :name                  => CGI::unescapeHTML(d.xpath("//岗位名称").children.to_s).html_safe,
            :location              => CGI::unescapeHTML(d.xpath("//工作地点").children.to_s).html_safe,
            :vacancy               => CGI::unescapeHTML(d.xpath("//岗位人数").children.to_s).html_safe,
            :salary_range          => CGI::unescapeHTML(d.xpath("//薪资范围").children.to_s).html_safe,
            :work_year_requirement => CGI::unescapeHTML(d.xpath("//工作年限").children.to_s).html_safe,
            :degree_requirement    => CGI::unescapeHTML(d.xpath("//学历要求").children.to_s).html_safe,
            :page_url              => d.xpath("//PageUrl").children.to_s,
            :desc                  => CGI::unescapeHTML(d.xpath("//职位描述").children.to_s),
            :company_name          => CGI::unescapeHTML(d.xpath("//公司名字").children.to_s).html_safe,
            :company_desc          => CGI::unescapeHTML(d.xpath("//公司简介").children.to_s),
            :contact               => CGI::unescapeHTML(d.xpath("//联系方式").children.to_s),
            :industry              => CGI::unescapeHTML(d.xpath("//公司行业").children.to_s).html_safe,
            :company_size          => CGI::unescapeHTML(d.xpath("//企业规模").children.to_s).html_safe,
            :company_type          => CGI::unescapeHTML(d.xpath("//企业性质").children.to_s).html_safe,
            :company_homepage      => CGI::unescapeHTML(d.xpath("//企业网站").children.to_s).html_safe,
            :company_address       => CGI::unescapeHTML(d.xpath("//公司地址").children.to_s).html_safe,
            :company_phone_number  => CGI::unescapeHTML(d.xpath("//联系电话").children.to_s).html_safe,
            :company_contact_name  => CGI::unescapeHTML(d.xpath("//联系人").children.to_s).html_safe,
            :email                 => CGI::unescapeHTML(d.xpath("//邮箱").children.to_s).html_safe,
            :state                 => '0'
          })

          if staging_job.save
            @saved_jobs << staging_job
          else
            @unsaved_jobs << staging_job
          end
        else
          @unsaved_jobs << staging_job
        end
      }
    else
      redirect_to :new
    end
  end

  def approve
    redirect_to :back, :notice => (get_object.approve ? "审核通过。" : "不能审核已经通过审核的。")
  end

  def reject
    redirect_to :back, :notice => (get_object.reject ? "审核不通过。" : "拒绝审核出错。")
  end

  def theme
    @jobs = Job.paginate :all, :page => params[:page], :per_page => 30
  end

  def update_themes
    edited_ids = params[:job_ids].try(:keys) ||[]
    non_themes_ids = params[:ids] - edited_ids

    if params[:job_ids]
      flash[:notice] = "Update successfully。"
      params[:job_ids].each do |job_id, themes|
        Job.update_all(["themes=?", themes.uniq.join(",")], ["id=?", job_id])
      end
    end

    # clean cancelled themes
    Job.update_all(["themes=?", ""], ["id in (?)", non_themes_ids])

    redirect_to :action => :theme, :page => params[:page]
  end

  def recommend_resumes
    @job = get_object

    if request.post?
      flash[:notice] = "Successed to recommend resumes."
    end
  end

  protected

  def set_company_desc_editor_html
    company_desc_html = @staging_job.company_desc.try(:html_safe).to_s.gsub('"','\'').gsub(/\s/, '')
    ("CKEDITOR.instances.company_desc_editor.setData(\"#{company_desc_html}\");").html_safe
  end
  helper_method :set_company_desc_editor_html

  def set_job_requirement_html
    job_requirement = @staging_job.desc.try(:html_safe).to_s.gsub('"', '\'').gsub(/\s/, '')
    ("CKEDITOR.instances.job_requirement.setData(\"#{job_requirement}\");").html_safe
  end
  helper_method :set_job_requirement_html

  def calculate_company_type(staging_job)
    CompanyType.to_sorted_a.detect do |t|
      staging_job.company_type.try(:html_safe).try(:include?, t.first)
    end
  end
  helper_method :calculate_company_type

  def calculate_industry(staging_job)
    CompanyIndustry.to_sorted_a.detect do |t|
      staging_job.industry.try(:html_safe).try(:include?, t.first)
    end
  end
  helper_method :calculate_industry

  def get_contact staging_job
    "#{CGI::unescapeHTML(staging_job.company_contact_name.try(:html_safe).to_s)} #{CGI::unescapeHTML(staging_job.email.try(:html_safe).to_s)}"
  end
  helper_method :get_contact
end