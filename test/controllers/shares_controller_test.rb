require 'test_helper'

class SharesControllerTest < ActionController::TestCase

  test "should create a share" do
    p = Post.find 1
    s = Site.find 1
    post :create, {post_id: p.id, site_id: s.id}
    assert_response 204
  end
end