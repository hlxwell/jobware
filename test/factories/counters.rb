# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :counter do |f|
  f.click 1
  f.happend_at "2010-08-31"
  f.parent_type "MyString"
  f.parent_id 1
  f.type "MyString"
end
