# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :partner_site_style do |f|
  f.partner_id 1
  f.header "MyText"
  f.footer "MyText"
  f.stylesheet "MyText"
end
