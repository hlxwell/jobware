require 'test_helper'

class JobApplicationsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => JobApplication.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    JobApplication.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    JobApplication.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to job_application_url(assigns(:job_application))
  end
  
  def test_edit
    get :edit, :id => JobApplication.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    JobApplication.any_instance.stubs(:valid?).returns(false)
    put :update, :id => JobApplication.first
    assert_template 'edit'
  end
  
  def test_update_valid
    JobApplication.any_instance.stubs(:valid?).returns(true)
    put :update, :id => JobApplication.first
    assert_redirected_to job_application_url(assigns(:job_application))
  end
  
  def test_destroy
    job_application = JobApplication.first
    delete :destroy, :id => job_application
    assert_redirected_to job_applications_url
    assert !JobApplication.exists?(job_application.id)
  end
end
