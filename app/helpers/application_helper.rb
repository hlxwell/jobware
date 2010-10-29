module ApplicationHelper
  include GoogleVisualization
  include UrlHelper

  def job_filter_link_to(options)
    raise "no option passed to job_filter_link_to function" if options.blank?

    url_hash = {
      :location      => options[:location].try(:last) || params[:location] || "",
      :tool          => options[:tool].try(:last) || params[:tool] || "",
      :category      => options[:category].try(:last) || params[:category] || "",
      :industry      => options[:industry].try(:last) || params[:industry] || "",
      :salary_range  => options[:salary_range].try(:last) || params[:salary_range] || "",
      :dateline      => options[:dateline].try(:last) || params[:dateline] || "",
      :contract_type => options[:contract_type].try(:last) || params[:contract_type] || ""
    }

    ### {:location => ["上海", "shanghai"]}
    if params[options.keys.first].to_s == options.values.first.last.to_s
      link_to options.values.first.first, filter_jobs_path(url_hash), :class => "black bold small_right_margin"
    else
      link_to options.values.first.first, filter_jobs_path(url_hash), :class => "small_right_margin"
    end
  end

  def company_filter_link_to(options)
    raise "no option passed to company_filter_link_to function" if options.blank?

    url_hash = {
      :location     => options[:location].try(:last) || params[:location] || "",
      :size         => options[:size].try(:last) || params[:size] || "",
      :company_type => options[:company_type].try(:last) || params[:company_type] || "",
      :industry     => options[:industry].try(:last) || params[:industry] || ""
    }

    ### {:location => ["上海", "shanghai"]}
    if params[options.keys.first].to_s == options.values.first.last.to_s
      link_to options.values.first.first, filter_companies_path(url_hash), :class => "black bold small_right_margin"
    else
      link_to options.values.first.first, filter_companies_path(url_hash), :class => "small_right_margin"
    end
  end

  def urgent_job_groups(group_size = 7)
    @urgent_jobs = Ad.urgent_jobs.opened.with_theme(current_theme_site)
    @urgent_jobs.in_groups_of(group_size)
  end

  # include ActsAsTaggableOn::TagsHelper
  def tag_cloud(tags, classes)
    tags = tags.all if tags.respond_to?(:all)
    return [] if tags.empty?
    max_count = tags.sort_by(&:count).last.count.to_f
    tags.each do |tag|
      if max_count > 1
        index = ((tag.count / max_count) * (classes.size - 1)).round
      else
        index = 0
      end
      yield tag, classes[index]
    end
  end

  def show_term
    render "shared/term"
  end

  #### set "title"
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end

  def show_tag_list tags, path
    result = ""
    tags.each do |tag|
      result += "<span class='tag'>#{tag}</span>"
    end
    raw result
  end

  def page_name_html(name, options)
    title(name) if options[:with_title]
    raw "<h2>#{name}</h2><div class='archive-separator'></div>"
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
      return raw("<div class='no_record'>没有数据</div>")
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

    plus_mark = (options[:with_plus] and int.to_f > 0) ? "+" : ""

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
      link_to(raw("<span class='red'>新</span>"), company_job_applications_path(:filter => :unread)) +
      raw("<strong class='loud red'>(#{count})</strong> |")
    end
  end

end