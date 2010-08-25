require 'test_helper'

class Jobseeker::SkillsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Jobseeker::skill.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Jobseeker::skill.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Jobseeker::skill.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to skill_url(assigns(:skill))
  end
  
  def test_edit
    get :edit, :id => Jobseeker::skill.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Jobseeker::skill.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Jobseeker::skill.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Jobseeker::skill.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Jobseeker::skill.first
    assert_redirected_to skill_url(assigns(:skill))
  end
  
  def test_destroy
    skill = Jobseeker::skill.first
    delete :destroy, :id => skill
    assert_redirected_to skills_url
    assert !Jobseeker::skill.exists?(skill.id)
  end
end
