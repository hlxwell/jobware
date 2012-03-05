# -*- encoding : utf-8 -*-
require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class Company::JobsControllerTest < ActionController::TestCase
  context "when activing a job" do
    setup do
      @company = Factory(:company)
      @company.user.charge!(1, :service_item_id => ServiceItem.job_credit_id)
      @job = Factory(:job, :company_id => @company.id)
    end

    context "without enough creit" do
      should "show error message" do
        get :want_to_show, {:id => @job.id}

        assert flash[:error].present?
      end
    end
  end
end
