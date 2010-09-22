require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Partner::CountersControllerTest < ActionController::TestCase
    
  context "index action" do
    should "render index template" do
      get :index
      assert_template 'index'
    end
  end
      
  context "show action" do
    should "render show template" do
      get :show, :id => Partner::Counters.first
      assert_template 'show'
    end
  end    
              
end
