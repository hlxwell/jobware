# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :ad do |f|
  f.company_id 1
  f.position 1
  f.type 1
  f.url "MyString"
  f.state "MyString"
  f.start_at "2010-08-31"
  f.end_at "2010-08-31"
end
