# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :subscription do |f|
  f.resume_id 1
  f.keywords "MyString"
  f.period_type 1
  f.last_sent_at "2010-08-31"
end
