require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Jobseeker::StarredJobsControllerTest < ActionController::TestCase
    
  context "index action" do
    should "render index template" do
      get :index
      assert_template 'index'
    end
  end
                
end
