require 'pp'
module ApplicationHelper
  def in_section?(name)
    case name
    when "jobseeker"
      current_page?('/home/a') or
      current_page?('/home/b')
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