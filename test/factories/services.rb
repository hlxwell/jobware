# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :service do |f|
  f.serving_target_type "MyString"
  f.name "MyString"
  f.desc "MyText"
  f.price 1
end
