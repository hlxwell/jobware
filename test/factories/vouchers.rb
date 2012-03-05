# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :voucher do |f|
  f.service_item_id 1
  f.user_id 1
  f.amount 1
  f.state "unactive"
end
