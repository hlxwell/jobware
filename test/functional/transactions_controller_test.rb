require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Partner::TransactionsControllerTest < ActionController::TestCase
    
  context "index action" do
    should "render index template" do
      get :index
      assert_template 'index'
    end
  end
      
  context "show action" do
    should "render show template" do
      get :show, :id => Partner::Transactions.first
      assert_template 'show'
    end
  end    
      
  context "new action" do
    should "render new template" do
      get :new
      assert_template 'new'
    end
  end
            
end
