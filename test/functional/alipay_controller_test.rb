require 'test_helper'

class AlipayControllerTest < ActionController::TestCase

  context "alipay" do
    setup do
      @notify_hash = {
        "price"=>"0.01",
        "discount"=>"0.00",
        "body"=>"向itjob.fm充值成功。",
        "out_trade_no"=>"1286782283",
        "quantity"=>"1",
        "total_fee"=>"0.01",
        "is_total_fee_adjust"=>"N",
        "trade_status"=>"TRADE_SUCCESS",
        "buyer_id"=>"2088002252988095",
        "subject"=>"ITJob.fm 账户充值 0.01元。",
        "gmt_create"=>"2010-10-11 14:36:14",
        "sign"=>"27c2eddc0bd1fc06dcca6638db132e4f",
        "seller_id"=>"2088002016425361",
        "notify_time"=>"2010-10-11 14:37:59",
        "use_coupon"=>"N",
        "trade_no"=>"2010101143803109",
        "notify_type"=>"trade_status_sync",
        "buyer_email"=>"hlxwell@gmail.com",
        "sign_type"=>"MD5",
        "notify_id"=>"2348ecbc6a5d88c034a7a2c8c213b1a000",
        "seller_email"=>"hlxwell@hotmail.com",
        "gmt_payment"=>"2010-10-11 14:37:58",
        "payment_type"=>"1"
      }
    end

    should "add money after been notified" do
      post :notify, @notify_hash
    end
  end

end
