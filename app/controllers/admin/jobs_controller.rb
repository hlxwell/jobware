# Controller generated by Typus, use it to extend admin functionality.
class Admin::JobsController < Admin::ResourcesController
  def approve
    get_object.approve!
    redirect_to :back, :notice => "审核通过。"
  end
end