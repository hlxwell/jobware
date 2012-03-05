# -*- encoding : utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :staging_job do |f|
  f.name "MyString"
  f.location "MyString"
  f.vacancy "MyString"
  f.industry "MyString"
  f.salary_range "MyString"
  f.work_year_requirement "MyString"
  f.degree_requirement "MyString"
  f.desc "MyText"
  f.company_name "MyString"
  f.company_desc "MyString"
  f.contact "MyString"
  f.state "MyString"
end
