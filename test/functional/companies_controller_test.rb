require 'test_helper'

class Company::CompaniesControllerTest < ActionController::TestCase
    
  context "index action" do
    should "render index template" do
      get :index
      assert_template 'index'
    end
  end
      
  context "show action" do
    should "render show template" do
      get :show, :id => Company::Companies.first
      assert_template 'show'
    end
  end    
        
  context "edit action" do
    should "render edit template" do
      get :edit, :id => Company::Companies.first
      assert_template 'edit'
    end
  end
        
end
