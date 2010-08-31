module ApplicationHelper

  #### set "title"
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end

  ### forcing use jobware form builder
  def jobware_form_for(*args, &block)
    options = args.extract_options!.merge(:builder => JobwareFormBuilder)

    if options[:use_fieldset].nil? or options[:use_fieldset]
      field_set_tag(options[:title], :class => 'big') { form_for(*(args + [options]), &block) }
    else
      form_for(*(args + [options]), &block)
    end
  end

  def render_message
    if flash[:notice].present?
      "<div class='notice largest'>#{flash[:notice]}</div>"
    elsif flash[:error].present?
	    "<div class='error largest'>#{flash[:error]}</div>"
    elsif flash[:success].present?
      "<div class='success largest'>#{flash[:success]}</div>"
    end
  end

  ### nav helper method
  def in_section?(name)
    case name
    when "jobseeker"
      current_page?(companies_path) or current_page?(jobs_path) or request.path =~ /^\/(jobs|companies)\/\d+/ or current_page?(new_jobseeker_resume_path)
    when "company"
      current_page?('/home/c') or current_page?(new_company_path)
    when "partner"
      current_page?('/home/e') or current_page?(new_partner_path)
    when "frontend"
      request.path !~ /^\/(company)|(jobseeker)|(partner)(.*)?/ or current_page?(new_partner_path) or current_page?(new_jobseeker_resume_path)
    else
      false
    end
  end

  def frontend_paths
    if in_section?("frontend")
      [request.path]
    end
  end

  def show_no_record collection, &block
    if collection.blank?
      raw "<p class='notice largest'>没有记录。</p>"
    else
      block.call
    end
  end
end