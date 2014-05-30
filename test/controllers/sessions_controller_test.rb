require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "should do login" do
    post :create, { username: 'pepe', password: 'password'}
    assert_routing root_path, controller: 'posts', action: 'index'
    assert_not_nil session[:user_id]
  end

  test "should do log out" do
    post :create, { username: 'pepe', password: 'password'}
    assert_routing root_path, controller: 'posts', action: 'index'
    assert_not_nil session[:user_id]

    get :destroy
    assert_nil session[:user_id]
  end
end