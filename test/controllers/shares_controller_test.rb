require 'test_helper'

class SharesControllerTest < ActionController::TestCase

  test "should create a share" do
    p = Post.find 1
    s = Site.find 1
    u = User.find 1
    session[:user_id] = u.id
    post :create, {post_id: p.id, site: s.name}
    assert_response 200
  end
end