require 'test_helper'

class RateTest < ActiveSupport::TestCase
  test "should create share" do
    u = User.find_by username: 'pepe'
    p = Post.find 2

    rt = Rate.create user_id: u.id, post_id: p.id, score: 3
    assert rt.save
  end

  test "should not create share" do
    u = User.find_by username: 'pepe'
    p = Post.find 1

    rt = Rate.create user_id: u.id, post_id: p.id
    assert_not rt.save
  end
end
