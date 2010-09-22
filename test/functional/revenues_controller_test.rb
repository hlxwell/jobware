require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Partner::RevenuesControllerTest < ActionController::TestCase
    
  context "index action" do
    should "render index template" do
      get :index
      assert_template 'index'
    end
  end
      
  context "show action" do
    should "render show template" do
      get :show, :id => Partner::Revenues.first
      assert_template 'show'
    end
  end    
              
end
