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
  end

  context "File Resume" do
    setup do
      @resume = Factory.build(:file_resume)
    end

    should "be file_resume of resume_type" do
      assert_equal 'file', @resume.resume_type
    end

    should "check file when it's file resume" do
      assert @resume.save
    end

    context "if input name" do
      setup do
        @resume.name = "xxx"
      end

      should "be builder_resume" do
        assert_equal "builder", @resume.resume_type
      end
    end
  end

  context "URL Resume" do
    setup do
      @resume = Factory.build(:url_resume)
    end

    should "be url_resume of resume_type" do
      assert_equal 'url', @resume.resume_type
    end

    should "check url when it's file resume" do
      assert @resume.save
    end

    should "require url" do
      @resume.url = ""
      @resume.resume_type = "url"
      assert @resume.url_resume?
      assert_equal false, @resume.save
      assert @resume.errors[:url].size > 0
    end
  end

  context "Builder Resume" do
    setup do
      @resume = Factory.build(:resume)
    end

    should "be builder_resume of resume_type" do
      assert_equal 'builder', @resume.resume_type
    end

    should "check name when it's builder resume" do
      assert @resume.save
    end

    should "check name" do
      @resume.name = nil
      assert 'builder', @resume.resume_type
      assert_equal false, @resume.save
    end
  end
end
