require File.join(File.dirname(__FILE__), '..', 'test_helper')


# 发布工作后就扣一个点.
# 初始状态：未审核，然后审核通过，显示“开始展示”按钮，展示中可以（关闭），(关闭)后可以(重开)，只要有效期的时间没有超过。过期显示“激活”按钮

# unapproved => approved
### if approved => show "start" button
# click "start" => opened

### if opened and available => show "close" button
# click "close" => closed
### if closed and available => show "reopen" button
# click reopen => opened

### if opened and unavailable => change state to "closed", show "active"
### if closed and unavailable => show "active" button
# click "active" => opened and substract 1 job_credit


class JobTest < ActiveSupport::TestCase
  context "a job" do
    setup do
      @company = Factory(:company)
      @company.user.charge!(1, :service_item_id => ServiceItem.job_credit_id)
      @job = Factory(:job, :company_id => @company.id)
    end

    context "after created" do
      should "be in a unapproved initial state" do
        assert @job.unapproved?
      end

      should "be able to approve and change state to closed" do
        assert @job.approve
        assert @job.closed?
      end

      should "be able to reject and change state to rejected" do
        assert @job.reject
        # assert @job.rejected?
      end
    end

    context "after rejected" do
      setup do
        @job.reject
      end

      should "be reapproved and change state to unapproved after update" do
        @job.name += "theplant"
        @job.save

        @job.expects(:reapprove).once
        assert @job.unapproved?
      end

      should "be able to approve" do
        assert @job.approve
        assert @job.closed?
      end
    end


    context "after approved" do
      setup do
        @job.approve
      end

      should "be in a closed state" do
        assert @job.closed?
      end

      should "be able to reject" do
        assert @job.reject
        # assert @job.rejected?
      end

      should "be able to active when job is unavailable" do
        assert_equal false, @job.available?
        @job.user.expects(:pay!).once
        assert @job.active
        assert @job.opened?
      end

      should "be in unapproved state after job is edited" do
        @job.save
        @job.expects(:reapprove).once
        # assert @job.unapproved?
      end
    end

    context "after actived" do
      setup do
        @job.approve
        @job.active
      end

      should "set the start_at and end_at" do
        assert @job.available?
      end

      should "in the opened state" do
        assert @job.opened?
      end

      should "be able to close" do
        assert @job.close
        assert @job.closed?
      end

      should "be in unapproved state after job is edited" do
        @job.save
        @job.expects(:reapprove).once
        # assert @job.unapproved?
      end
    end

    context "if job is set as highlighted" do
      setup do
        @job.highlighted = true
        @job.save
        @job.approve
      end

      should "not be able to active." do
        assert_equal false, @job.active
      end

      should "be able to active after have creidt" do
        @company.user.charge!(1, :service_item_id => ServiceItem.job_highlight_credit_id)
        assert @job.active
      end
    end

  end
end
