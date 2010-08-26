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
      ['a','ab','ac','ad'].map {|w| current_page?("/home/#{w}") }.include?(true) or
      current_page?(companies_path)
    when "company"
      current_page?('/home/c') or
      current_page?('/companies/new')
    when "partner"
      current_page?('/home/e') or
      current_page?('/home/f')
    when "frontend"
      !('g'..'z').to_a.map {|w| current_page?("/home/#{w}") }.include?(true)
    else
      false
    end
  end
end