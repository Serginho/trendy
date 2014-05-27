require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "should do login" do
    post :create, post: { username: 'pepe', password: 'password'}
    assert_redirected_to '/'
  end
end