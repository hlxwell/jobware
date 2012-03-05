# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :service_item do |f|
  f.type "MyString"
  f.name "MyString"
  f.desc "MyText"
  f.service_length 1
end
