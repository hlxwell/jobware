# -*- encoding : utf-8 -*-
require File.join(File.dirname(__FILE__), '..', 'test_helper')

class AlipayControllerTest < ActionController::TestCase

  context "alipay" do
    setup do
      add_service_items

      @notify_hash = {
        "price"=>"0.01",
        "extra_common_param"=>"1",
        "discount"=>"0.00",
        "body"=>"向itjob.fm充值。",
        "out_trade_no"=>"1286786509",
        "quantity"=>"1",
        "total_fee"=>"0.01",
        "is_total_fee_adjust"=>"N",
        "trade_status"=>"TRADE_SUCCESS",
        "buyer_id"=>"2088002252988095",
        "subject"=>"ITJob.fm 账户充值 0.01元",
        "gmt_create"=>"2010-10-11 16:33:13",
        "sign"=>"57a9824eb273b218f279d080c60c66db",
        "seller_id"=>"2088002016425361",
        "notify_time"=>"2010-10-11 16:35:50",
        "use_coupon"=>"N",
        "trade_no"=>"2010101144836409",
        "notify_type"=>"trade_status_sync",
        "buyer_email"=>"hlxwell@gmail.com",
        "sign_type"=>"MD5",
        "notify_id"=>"3182928f94fac335d7862f9e05728d0c00",
        "seller_email"=>"hlxwell@hotmail.com",
        "gmt_payment"=>"2010-10-11 16:35:50",
        "payment_type"=>"1"
      }
      @user = Factory(:user)
    end

    should "add money after been notified" do
      User.stubs(:find_by_id).returns(@user)
      post :notify, @notify_hash
      assert @user.remains(ServiceItem.money_id) > 0
    end
  end

end
