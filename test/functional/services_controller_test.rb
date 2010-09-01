require 'test_helper'

class Jobseeker::ServicesControllerTest < ActionController::TestCase
    
  context "index action" do
    should "render index template" do
      get :index
      assert_template 'index'
    end
  end
      
  context "show action" do
    should "render show template" do
      get :show, :id => Jobseeker::Services.first
      assert_template 'show'
    end
  end    
              
end
