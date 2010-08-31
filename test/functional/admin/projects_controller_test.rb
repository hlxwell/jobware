require "test_helper"

# ControllerTest generated by Typus, use it to test the extended admin functionality.
class Admin::ProjectsControllerTest < ActionController::TestCase

  setup do
    admin = admin_users(:admin)
    @request.session[:typus_user_id] = admin.id
  end

  test "should render index" do
    get :index
    assert_template :index
  end

  test "should render new" do
    get :new
    assert_template :new
  end

end
