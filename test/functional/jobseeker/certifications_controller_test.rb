require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Jobseeker::CertificationsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Jobseeker::certification.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Jobseeker::certification.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Jobseeker::certification.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to certification_url(assigns(:certification))
  end
  
  def test_edit
    get :edit, :id => Jobseeker::certification.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Jobseeker::certification.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Jobseeker::certification.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Jobseeker::certification.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Jobseeker::certification.first
    assert_redirected_to certification_url(assigns(:certification))
  end
  
  def test_destroy
    certification = Jobseeker::certification.first
    delete :destroy, :id => certification
    assert_redirected_to certifications_url
    assert !Jobseeker::certification.exists?(certification.id)
  end
end
