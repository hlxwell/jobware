class Jobseeker::SubscriptionsController < Jobseeker::BaseController

  def edit
    @subscription = current_user.jobseeker.subscription || Subscription.new
  end

  def update
    @subscription = current_user.jobseeker.subscription
    
    if @subscription.update_attributes(params[:subscription])
      flash[:success] = "更新成功。"
      redirect_to edit_jobseeker_subscription_path
    else
      render :edit
    end
  end

  def create
    @subscription = current_user.jobseeker.build_subscription(params[:subscription])
    if @subscription.save
      flash[:success] = "订阅成功。"
      redirect_to edit_jobseeker_subscription_path
    else
      render :new
    end
  end
end