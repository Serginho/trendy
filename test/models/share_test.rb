require 'test_helper'

class ShareTest < ActiveSupport::TestCase

  test "Should create a share" do
    u = User.find_by username: 'pepe'
    p = Post.find 1
    s = Site.find 1

    sh = Share.create user_id: u.id, post_id: p.id, site_id: s.id
    assert sh.save
  end

  test "Should not create a share (uniqueness)" do
    u = User.find_by username: 'pepe'
    p = Post.find 2
    s = Site.find 2

    sh = Share.create user_id: u.id, post_id: p.id, site_id: s.id
    assert sh.save

    sh2 = Share.create user_id: u.id, post_id: p.id, site_id: s.id
    assert_not sh2.save

    u = User.find_by username: 'juan'
    sh = Share.create user_id: u.id, post_id: p.id, site_id: s.id
    assert sh.save

  end

  test "Should not create a share with nil parameter" do
    u = User.find_by username: 'pepe'
    p = Post.find 2

    sh = Share.create user_id: u.id, post_id: p.id
    assert_not sh.save
  end
end
