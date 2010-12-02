class AlipayController < ApplicationController
  before_filter :login_required, :only => :pay
  skip_before_filter :verify_authenticity_token, :only => :notify

  def pay
    @charge_amount = params[:charge_amount]
    redirect_to :back, :notice => "必须输入大于1的充值金额。" if @charge_amount.blank? or @charge_amount.to_f < 1
  end

  def notify
    notification = ActiveMerchant::Billing::Integrations::Alipay::Notification.new(request.raw_post)

    ### TODO
    user = User.find_by_id(notification.extra_common_param)
    raise "Wrong Alipay notification, can't find user." if user.blank?

    ### check if the notification is correct.
    notification.acknowledge

    case notification.status
    when "WAIT_BUYER_PAY", "TRADE_CLOSED"
      raise "Money didn't paid."
    when "TRADE_FINISHED", "TRADE_SUCCESS"
      user.charge!(
        notification.total_fee,
        :from => "支付宝 交易号：#{notification.trade_no}",
        :note => params.inspect,
        :partner_id => current_partner
      )
      render :text => "success"
      return
    else
      raise "Money didn't arrived."
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