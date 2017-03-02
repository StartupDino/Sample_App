require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = User.new(name: "Example User", email: "example@email.com",
        password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = "      "
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = "   "
  	assert_not @user.valid?
  end

  test "name should not be too long" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = "a" * 61 + "@example.com"
  	assert_not @user.valid?
  end

  test "emails should be formatted" do
  	valid_format = %w[user@example.com USER@foo.COM A_us-er@bar.org first.last@ex.com first+add@asd.dd]
  	valid_format.each do |x|
  		@user.email = x
  		assert @user.valid?, "#{x.inspect} should be valid"
  	end
  end

  test "emails should reject bad formats" do
  	invalid_format = %w[user@example,com foo@foo..com user_at_foo.org user.name@example.
  		foo@bar_baz.com foo@bar+baz.com]
  		invalid_format.each do |y|
  			@user.email = y
  			assert_not @user.valid?, "#{y.inspect} should be invalid"
  		end
  	end

  	test "emails should be unique" do
  		duplicate_user = @user.dup
  		duplicate_user.email = @user.email.upcase
  		@user.save
  		assert_not duplicate_user.valid?
  	end

  end
