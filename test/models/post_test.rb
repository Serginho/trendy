require 'test_helper'

class PostTest < ActiveSupport::TestCase

  test "should create post" do
    p = Post.create title: 'This is a post', content: 'This is an example of content to fit the gap', image: 'http://image.com/image.jpg', url: 'http://url.com/uri', category_id: 1
    assert p.save
    p = Post.create title: 'This is a post2', content: 'This is an example of content to fit the gap', url: 'http://url.com/uri', category_id: 1
    assert p.save
  end

  test "should detect duplicate post" do
    p = Post.create title: 'This is a post3', content: 'This is an example of content to fit the gap2', image: 'http://image.com/img', url: 'http://url.com/uri', category_id: 1
    assert p.save
    p = Post.create title: 'This is a post3', content: 'This is an example of content to fit the gap2 diferent', image: 'http://image.com/img', url: 'http://url.com/uri', category_id: 1
    assert_not p.save
  end

  test "should validate url" do
    p = Post.create title: 'This is a post22', content: 'This is an example of content to fit the gap2', image: 'http', url: 'http://url.com/uri', category_id: 1
    assert_not p.save
    p = Post.create title: 'This is a post22', content: 'This is an example of content to fit the gap2', image: 'http://image.com/img', url: 'test and test', category_id: 1
    assert_not p.save
  end

  test "should detect short content" do
    p = Post.create title: 'This is a podst3', content: 'This is an exam', image: 'http://image.com/img', url: 'http://url.com/uri', category_id: 1
    assert_not p.save
  end

end
