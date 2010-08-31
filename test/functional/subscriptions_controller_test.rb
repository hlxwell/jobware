require 'test_helper'

class Jobseeker::SubscriptionsControllerTest < ActionController::TestCase
      
  context "show action" do
    should "render show template" do
      get :show, :id => Jobseeker::Subscriptions.first
      assert_template 'show'
    end
  end    
      
  context "new action" do
    should "render new template" do
      get :new
      assert_template 'new'
    end
  end
      
  context "edit action" do
    should "render edit template" do
      get :edit, :id => Jobseeker::Subscriptions.first
      assert_template 'edit'
    end
  end
        
end
