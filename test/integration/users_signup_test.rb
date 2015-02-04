require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup does not create new user' do
    get signup_path
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      post users_path user: { name:  "",
                           email: "user@invalid",
                           password:              "foo",
                           password_confirmation: "bar" }
    end
    assert_template 'users/new'
    assert_template 'shared/_error_messages'
  end
  
  test 'valid signup saves to user to database' do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path user: { name: "Name",
                                            email: "valid@valid.com",
                                            password: "foobar1",
                                            password_confirmation: "foobar1"
      }
    end
    assert_template 'users/show'
  end
  
end
