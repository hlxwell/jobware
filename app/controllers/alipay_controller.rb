class AlipayController < ApplicationController
  before_filter :login_required, :only => :pay

  def pay
    @charge_amount = params[:charge_amount]
    redirect_to :back, :notice => "必须输入充值的金额。" if @charge_amount.blank? or @charge_amount.to_f <= 0
  end

  def notify
    notification = ActiveMerchant::Billing::Integrations::Alipay::Notification.new(request.raw_post)

    ### TODO
    user = User.find_by_id(notification.out_trade_no)
    raise "Wrong Alipay notification, can't find user." if user

    notification.acknowledge

    case notification.status
    when "WAIT_BUYER_PAY"
    when "TRADE_CLOSED"
    when "TRADE_SUCCESS"
    when "TRADE_FINISHED"
      user.charge!(
        notification.total_fee,
        :from => "支付宝 交易号：#{notification.trade_no}",
        :note => "notify_id: #{notification.notify_id},
          status: #{notification.trade_status},
          status: #{notification.trade_status},
          received_at: #{notification.notify_time}"
      )
    else
    end
  end

  def done
    @result = ActiveMerchant::Billing::Integrations::Alipay::Return.new(request.query_string)
    if @result.success?
      UserSession.create(User.find_by_id(@result.order))
      render :done
    else
      logger.warn(@result.message)
      render :error
    end
  end

  def error
  end
end