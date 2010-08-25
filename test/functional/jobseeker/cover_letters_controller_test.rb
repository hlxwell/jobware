require 'test_helper'

class Jobseeker::CoverLettersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Jobseeker::coverLetter.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Jobseeker::coverLetter.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Jobseeker::coverLetter.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to cover_letter_url(assigns(:cover_letter))
  end
  
  def test_edit
    get :edit, :id => Jobseeker::coverLetter.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Jobseeker::coverLetter.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Jobseeker::coverLetter.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Jobseeker::coverLetter.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Jobseeker::coverLetter.first
    assert_redirected_to cover_letter_url(assigns(:cover_letter))
  end
  
  def test_destroy
    cover_letter = Jobseeker::coverLetter.first
    delete :destroy, :id => cover_letter
    assert_redirected_to cover_letters_url
    assert !Jobseeker::coverLetter.exists?(cover_letter.id)
  end
end
