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
    [:notice, :error, :success].each do |key|
      if flash[key].present?
        result = "<div class='#{key} largest'>#{flash[key]}</div>"
        flash.discard(key)
        return result
      end
    end
    nil
  end

  ### nav helper method
  def in_section?(name)
    case name
    when "jobseeker"
      current_page?(companies_path) or current_page?(jobs_path) or request.path =~ /^\/(jobs|companies)\/\d+/ or current_page?(new_jobseeker_resume_path)
    when "company"
      current_page?('/company_benifit') or current_page?(new_company_path)
    when "partner"
      current_page?('/partner_benifit') or current_page?(new_partner_path)
    when "frontend"
      request.path !~ /^\/(company)|(jobseeker)|(partner)(.*)?/ or
        current_page?(new_partner_path) or
        current_page?(new_jobseeker_resume_path) or
        request.path =~ /((company)|(partner))_benifit/
    else
      false
    end
  end

  def frontend_paths
    [request.path] if in_section?("frontend")
  end

  def jobseeker_section_paths
    [request.path] if request.path =~ /^\/jobseeker\//
  end

  def partner_section_paths
    [request.path] if request.path =~ /^\/partner\//
  end

  def company_section_paths
    [request.path] if request.path =~ /^\/company\//
  end

  def show_no_record collection, &block
    if collection.blank?
      return raw("<div class='notice largest'>没有记录。</div>")
    else
      block.call
      return ""
    end
  end

  def format_price(number, options={})
    # :currency_before => false puts the currency symbol after the number
    # default format: $12,345,678.90
    options = {:currency_symbol => "¥", :delimiter => ",", :decimal_symbol => ".", :currency_before => true, :with_plus => false}.merge(options)
    # split integer and fractional parts
    int, frac = ("%.1f" % number).split('.')

    plus_mark = (options[:with_plus] and int.to_i > 0) ? "+" : ""

    # insert the delimiters
    int.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{options[:delimiter]}")

    if options[:currency_before]
      options[:currency_symbol] + " #{plus_mark}" + int + options[:decimal_symbol] + frac
    else
      plus_mark + int + options[:decimal_symbol] + frac + options[:currency_symbol]
    end
  end

  def display_new_jobapplication_count
    count = if @new_job_application_count.present?
      @new_job_application_count
    elsif current_user.try(:company).present?
      current_user.company.job_applications.unread.count
    else
      0
    end

    if count > 0
      link_to("新", company_job_applications_path(:filter => :unread)) +
      raw("<strong class='loud'>(#{count})</strong> |")
    end
  end

end