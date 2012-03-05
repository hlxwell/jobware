# -*- encoding : utf-8 -*-
require File.join(File.dirname(__FILE__), '..', 'test_helper')

class CompaniesControllerTest < ActionController::TestCase

  context "new action" do
    setup do
      post :create,  {"company"=>{
        "address"=>"杭州eac c1407",
        "city"=>"杭州",
        "name"=>"杭州大浪软件技术有限公司 #{rand(1000)}",
        "contact_name"=>"anatole",
        "size"=>"2",
        "open_contact"=>"1",
        "logo"=> File.open(File.join(Rails.root, "test", "files", "file.gif")),
        "company_type"=>"2",
        "tag_list"=>"iphone, rails",
        "homepage"=>"http://theplant.jp",
        "desc"=>"nothing",
        "province"=>"浙江",
        "user_attributes"=>{"password_confirmation"=>"123321",
        "password"=>"123321",
        "email"=>"hlxwell+yes@gmail.com"}}
      }
      @company = assigns(:company)
    end

    should "send active code mail" do
      assert_sent_email do |email|
        email.body.include?(@company.user.perishable_token)
      end
    end

    should redirect_to "/companies/created"
  end
end
