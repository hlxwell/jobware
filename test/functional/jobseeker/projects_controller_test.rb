require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Jobseeker::ProjectsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Jobseeker::project.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Jobseeker::project.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Jobseeker::project.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to project_url(assigns(:project))
  end
  
  def test_edit
    get :edit, :id => Jobseeker::project.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Jobseeker::project.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Jobseeker::project.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Jobseeker::project.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Jobseeker::project.first
    assert_redirected_to project_url(assigns(:project))
  end
  
  def test_destroy
    project = Jobseeker::project.first
    delete :destroy, :id => project
    assert_redirected_to projects_url
    assert !Jobseeker::project.exists?(project.id)
  end
end
