require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Partner::AdPositionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Partner::adPosition.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Partner::adPosition.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Partner::adPosition.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to partner/ad_position_url(assigns(:partner/ad_position))
  end
  
  def test_edit
    get :edit, :id => Partner::adPosition.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Partner::adPosition.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Partner::adPosition.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Partner::adPosition.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Partner::adPosition.first
    assert_redirected_to partner/ad_position_url(assigns(:partner/ad_position))
  end
  
  def test_destroy
    partner/ad_position = Partner::adPosition.first
    delete :destroy, :id => partner/ad_position
    assert_redirected_to partner/ad_positions_url
    assert !Partner::adPosition.exists?(partner/ad_position.id)
  end
end
