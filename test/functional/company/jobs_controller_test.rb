require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Company::JobsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Company::job.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Company::job.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Company::job.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to company/job_url(assigns(:company/job))
  end
  
  def test_edit
    get :edit, :id => Company::job.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Company::job.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Company::job.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Company::job.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Company::job.first
    assert_redirected_to company/job_url(assigns(:company/job))
  end
  
  def test_destroy
    company/job = Company::job.first
    delete :destroy, :id => company/job
    assert_redirected_to company/jobs_url
    assert !Company::job.exists?(company/job.id)
  end
end
