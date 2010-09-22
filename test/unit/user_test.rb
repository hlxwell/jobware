require File.join(File.dirname(__FILE__), '..', 'test_helper')

class UserTest < ActiveSupport::TestCase
  context "User" do
    setup do
    end

    should "require email and password" do
      correct_hash = {:email => "xxx@gmail.com", :password => "123321", :password_confirmation => "123321"}
      incorrect_hash = {:email => "xxxcom", :password => "1233211", :password_confirmation => "123321"}

      assert User.new(correct_hash).valid?
      assert User.new(incorrect_hash).invalid?
    end

    should "be able to save" do
      u = Factory.build(:user)
      assert u.valid?
    end

    context "after save" do
      setup do
      end

      should "should create an bank account" do
      end
    end
  end
end
