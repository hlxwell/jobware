require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Partner::PartnerSiteStylesControllerTest < ActionController::TestCase
      
  context "show action" do
    should "render show template" do
      get :show, :id => Partner::PartnerSiteStyles.first
      assert_template 'show'
    end
  end    
        
  context "edit action" do
    should "render edit template" do
      get :edit, :id => Partner::PartnerSiteStyles.first
      assert_template 'edit'
    end
  end
        
end
