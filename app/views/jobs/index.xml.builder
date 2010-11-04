xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"

xml.jobs do
  xml.job_board_name("#{current_theme_site.try(:capitalize)}最新招聘信息")
  xml.link_to_home("http://#{request.host}")
  xml.no_record_text("暂时没有工作。")
  xml.more_jobs_text("更多#{current_theme_site}工作")
  @jobs.each do |job|
    xml.job do job
      xml.id(job.id)
      xml.posted_at(job.updated_at)
      xml.link_to_company(company_url(job.company))
      xml.link_to_job(job_url(job))
      xml.title(job.name)
      xml.company(job.company.name)
      xml.location(job.location)
      xml.salary("工资：#{job.salary_range_humanize}")
      xml.description(truncate(job.meta_description, :length => 500))

      if job.company.logo.size
        xml.image_thumb_path(job.company.logo.url(:thumb))
      else
        xml.image_thumb_path("missing.jpg")
      end

      if job.company.logo.size
        xml.image_preview_path(job.company.logo.url(:preview))
      else
        xml.image_preview_path("missing.jpg")
      end

      if job.company.logo.size
        xml.image_widget_path(job.company.logo.url(:widget))
      else
        xml.image_widget_path("missing.jpg")
      end
    end
  end
end