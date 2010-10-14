require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ResumeTest < ActiveSupport::TestCase
  context "Resume" do
    setup do
      @resume = Factory.build(:resume)
    end

    should "send confirmation mail" do
      @resume.expects(:send_confirmation).once
      assert @resume.save
    end
    
    should "check file when create file resume" do
      
    end
    
    should "check file when update text resume, but allow blank" do
      
    end
  end
  
end
