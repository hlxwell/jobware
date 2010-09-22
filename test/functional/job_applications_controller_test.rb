require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Company::JobApplicationsControllerTest < ActionController::TestCase
    
  context "index action" do
    should "render index template" do
      get :index
      assert_template 'index'
    end
  end
      
  context "show action" do
    should "render show template" do
      get :show, :id => Company::JobApplications.first
      assert_template 'show'
    end
  end    
              
end
