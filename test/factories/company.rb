Factory.define :company do |a|
  a.user            { |user| user.association(:user) }
  a.name            "ThePlant"
  a.desc            "我们公司是杭州最大的Rails公司"
  a.province        "浙江"
  a.city            "杭州"
  a.size            1
  a.company_type    1 
  a.phone_number    "88886666"
  a.contact_name    "Anatole"
  a.homepage        "http://www.theplant.jp"
  a.address         "xxxxxxxx"
  a.logo            File.open("test/files/file.gif")
end