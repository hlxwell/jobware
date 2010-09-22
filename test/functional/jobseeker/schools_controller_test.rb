require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Jobseeker::SchoolsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Jobseeker::school.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Jobseeker::school.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Jobseeker::school.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to school_url(assigns(:school))
  end
  
  def test_edit
    get :edit, :id => Jobseeker::school.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Jobseeker::school.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Jobseeker::school.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Jobseeker::school.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Jobseeker::school.first
    assert_redirected_to school_url(assigns(:school))
  end
  
  def test_destroy
    school = Jobseeker::school.first
    delete :destroy, :id => school
    assert_redirected_to schools_url
    assert !Jobseeker::school.exists?(school.id)
  end
end
