require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ResumeTest < ActiveSupport::TestCase
  context "Resume" do
    setup do
      @resume = Factory.build(:resume)
    end

    should "description" do
      @resume.expects(:send_confirmation).once
      assert @resume.save
    end
  end
  
end
