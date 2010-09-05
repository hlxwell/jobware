Factory.define :job do |a|
  a.company         { |company| company.association(:company) }
  a.name            "This is a normal job"
  a.text            "This is an awesome job,Please check it out"
  a.location        "Hz,China"
  a.en              true
  a.ja              true
  a.hours           "0-24"
  a.contract_type   {|c| c.association(:contract_type_1) }
  a.category        {|c| c.association(:category_1) }
  a.internal_id     "100"
  a.approved_at     Time.now
end