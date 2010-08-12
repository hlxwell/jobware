require 'pp'
module ApplicationHelper
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