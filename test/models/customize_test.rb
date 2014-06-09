require 'test_helper'

class CustomizeTest < ActiveSupport::TestCase

  test "should create customize" do
    u = User.find_by username: 'pepe'
    c = Category.find 24

    cm = Customize.create user_id: u.id, category_id: c.id, rank: 3
    assert cm.save
  end

  test "should not create customize" do
    u = User.find_by username: 'pepe'
    c = Category.find 30

    cm = Customize.create user_id: u.id, category_id: c.id
    assert_not cm.save
  end
end
