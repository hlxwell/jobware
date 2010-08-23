module ApplicationHelper
  def title(page_title, show_title = true)
    @content_for_title = page_title.to_s
    @show_title = show_title
  end
  
  def render_message
    if flash[:notice].present?
      "<br><div class='notice largest'>#{flash[:notice]}</div>"
    elsif flash[:error].present?
	    "<br><div class='error largest'>#{flash[:error]}</div>"
    elsif flash[:success].present?
      "<br><div class='success largest'>#{flash[:success]}</div>"
    end
  end

  def in_section?(name)
    case name
    when "jobseeker"
      ['a','ab','ac','ad'].map {|w| current_page?("/home/#{w}") }.include?(true)
    when "company"
      current_page?('/home/c') or
      current_page?('/home/d')
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