# -*- encoding : utf-8 -*-
Factory.define :job do |a|
  a.company           { |company| company.association(:company) }
  a.name              "advanced rails developer"
  a.desc              "This is an awesome job,Please check it out"
  a.requirement       "5 years experience on rails"
  a.content           "maintain company site."
  a.location_province "浙江"
  a.location_city     "杭州"
  a.vacancy           "1"
  a.contract_type     1
  a.category          1
  a.salary_range      1
end
