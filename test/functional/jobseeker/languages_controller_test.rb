require 'test_helper'

class Jobseeker::LanguagesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Jobseeker::language.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Jobseeker::language.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Jobseeker::language.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to language_url(assigns(:language))
  end
  
  def test_edit
    get :edit, :id => Jobseeker::language.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Jobseeker::language.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Jobseeker::language.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Jobseeker::language.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Jobseeker::language.first
    assert_redirected_to language_url(assigns(:language))
  end
  
  def test_destroy
    language = Jobseeker::language.first
    delete :destroy, :id => language
    assert_redirected_to languages_url
    assert !Jobseeker::language.exists?(language.id)
  end
end
