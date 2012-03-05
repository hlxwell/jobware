# -*- encoding : utf-8 -*-
Factory.define :resume, :class => Resume do |r|
  r.user           { |resume| resume.association(:user) }
  r.name              "王小白"
  r.gender            Gender::MALE
  r.working_years     "4"
  r.degree            Degree::MASTER
  r.major             "计算机"
  r.birthday          20.years.ago
  r.hometown_province "浙江"
  r.hometown_city     "杭州"
  r.current_residence_province "浙江"
  r.current_residence_city "杭州"
  r.email             "hlxwell@gmail.com"
  r.phone_number      "13812341234"
  r.expected_salary   "9000"
  r.expected_positions "项目经理"
  r.expected_job_location "杭州"
  r.current_working_state WorkingState::WORKING
  r.self_intro "I am cool."
end

Factory.define :url_resume, :class => Resume do |r|
  r.url "http://www.itjob.fm"
end

Factory.define :file_resume, :class => Resume do |r|
  r.file  File.open("test/files/file.doc")
end
