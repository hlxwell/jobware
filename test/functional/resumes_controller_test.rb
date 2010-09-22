require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ResumesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Resume.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Resume.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Resume.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to resume_url(assigns(:resume))
  end
  
  def test_edit
    get :edit, :id => Resume.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Resume.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Resume.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Resume.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Resume.first
    assert_redirected_to resume_url(assigns(:resume))
  end
  
  def test_destroy
    resume = Resume.first
    delete :destroy, :id => resume
    assert_redirected_to resumes_url
    assert !Resume.exists?(resume.id)
  end
end
