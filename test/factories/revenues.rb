# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :revenue do |f|
  f.partner_id 1
  f.period_start_at "2010-08-31"
  f.period_end_at "2010-08-31"
  f.state "MyString"
end
