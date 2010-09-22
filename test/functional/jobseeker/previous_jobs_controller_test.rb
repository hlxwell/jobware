require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Jobseeker::PreviousJobsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Jobseeker::previousJob.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Jobseeker::previousJob.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Jobseeker::previousJob.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to previous_job_url(assigns(:previous_job))
  end
  
  def test_edit
    get :edit, :id => Jobseeker::previousJob.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Jobseeker::previousJob.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Jobseeker::previousJob.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Jobseeker::previousJob.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Jobseeker::previousJob.first
    assert_redirected_to previous_job_url(assigns(:previous_job))
  end
  
  def test_destroy
    previous_job = Jobseeker::previousJob.first
    delete :destroy, :id => previous_job
    assert_redirected_to previous_jobs_url
    assert !Jobseeker::previousJob.exists?(previous_job.id)
  end
end
