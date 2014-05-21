require 'test_helper'

class TrainingPostTest < ActiveSupport::TestCase

  test "should create training post" do
    p = TrainingPost.create title: 'This is a post', content: 'This is an example of content to fit the gap', category_id: 1
    assert p.save
  end

  test "should detect short content" do
    p = TrainingPost.create title: 'This is a podst3', content: 'This is an exam', category_id: 1
    assert_not p.save
  end

end
