require File.join(File.dirname(__FILE__), '..', 'test_helper')

class CompanyTest < ActiveSupport::TestCase
  context "company" do
    setup do
      @hash = {
        "address"=>"上海市",
        "city"=>"徐",
        "name"=>"上海巨一科技",
        "contact_name"=>"张",
        "size"=>"3",
        "open_contact"=>"1",
        "phone_number"=>"6467-7777",
        "company_type"=>"1",
        "tag_list"=>"java",
        "homepage"=>"http://www.justonetech.com",
        "desc"=>"上海",
        "province"=>"上海",
        "industry"=>"1",
        "logo" => File.open("test/files/file.gif"),
        "user_attributes"=>{
          "password_confirmation"=>"123321", 
          "password"=>"123321", 
          "email"=>"hlxwell@gmail.com"
        }
      }
    end

    should "be able to save" do
      company = Company.new @hash
      assert company.save
    end
  end

end
