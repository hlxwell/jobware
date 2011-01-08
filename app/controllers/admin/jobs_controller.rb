# Controller generated by Typus, use it to extend admin functionality.
require 'nokogiri'

class Admin::JobsController < Admin::ResourcesController
  def new
    @staging_jobs = StagingJob.paginate :all, :page => params[:page], :per_page => 30
  end

  def import
    @staging_job = StagingJob.find_by_id(params[:id]) || StagingJob.new

    if request.get?
      @company = Company.new
      @company.build_user
      @company.jobs.build
    elsif request.post?
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

        flash[:notice] = "工作创建成功。"
        redirect_to "/admin/users/edit/#{@company.user.id}"
        return
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
        staging_job = StagingJob.new({
          :origin_id => d.xpath("//ID").children.to_s.html_safe,
          :name => d.xpath("//岗位名称").children.to_s.html_safe,
          :location => d.xpath("//工作地点").children.to_s.html_safe,
          :vacancy => d.xpath("//岗位人数").children.to_s.html_safe,
          :salary_range => d.xpath("//薪资范围").children.to_s.html_safe,
          :work_year_requirement => d.xpath("//工作年限").children.to_s.html_safe,
          :degree_requirement => d.xpath("//学历要求").children.to_s.html_safe,
          :page_url => d.xpath("//PageUrl").children.to_s.html_safe,
          :desc => d.xpath("//职位描述").children.to_s.html_safe,
          :company_name => d.xpath("//公司名字").children.to_s.html_safe,
          :company_desc => d.xpath("//公司简介").children.to_s.html_safe,
          :contact => d.xpath("//联系方式").children.to_s.html_safe,
          :industry => d.xpath("//公司行业").children.to_s.html_safe,
          :company_size => d.xpath("//企业规模").children.to_s.html_safe,
          :company_type => d.xpath("//企业性质").children.to_s.html_safe,
          :company_homepage => d.xpath("//企业网站").children.to_s.html_safe,
          :company_address => d.xpath("//公司地址").children.to_s.html_safe,
          :company_phone_number => d.xpath("//联系电话").children.to_s.html_safe,
          :company_contact_name => d.xpath("//联系人").children.to_s.html_safe,
          :email => d.xpath("//邮箱").children.to_s.html_safe,
          :state => '0'
        })

        if staging_job.save
          @saved_jobs << staging_job
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
end