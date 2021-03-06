require 'test_helper'

class PostTest < ActiveSupport::TestCase

  test "should create post" do
    p = Post.create title: 'This is a post', content: 'This is an example of content to fit the gap', image: 'http://image.com/image.jpg', url: 'http://url.com/uri', category_id: 26, source_id: 1
    assert p.save
    p = Post.create title: 'This is a post2', content: 'This is an example of content to fit the gap', url: 'http://url.com/uri', category_id: 26, source_id: 1
    assert p.save
  end

  test "should insert without image" do
    p = Post.create title: 'This is a post34', content: 'This is an example of content to fit the gap', url: 'http://url.com/uri', category_id: 26, source_id: 1
    assert p.save
  end

  test "should not insert without some id" do
    p = Post.create title: 'This is a post333', content: 'This is an example of content to fit the gap', image: 'http://image.com/image.jpg', url: 'http://url.com/uri', category_id: 26
    assert_not p.save
    p = Post.create title: 'This is a post333', content: 'This is an example of content to fit the gap', image: 'http://image.com/image.jpg', url: 'http://url.com/uri', source_id: 1
    assert_not p.save
  end

  test "should detect duplicate post" do
    p = Post.create title: 'This is a post3', content: 'This is an example of content to fit the gap2', image: 'http://image.com/img', url: 'http://url.com/uri', category_id: 26, source_id: 1
    assert p.save
    p = Post.create title: 'This is a post3', content: 'This is an example of content to fit the gap2 diferent', image: 'http://image.com/img', url: 'http://url.com/uri', category_id: 26, source_id: 1
    assert_not p.save
  end

  test "should validate url" do
    p = Post.create title: 'This is a post22', content: 'This is an example of content to fit the gap2', image: 'http', url: 'http://url.com/uri', category_id: 26, source_id: 1
    assert_not p.save
    p = Post.create title: 'This is a post22', content: 'This is an example of content to fit the gap2', image: 'http://image.com/img', url: 'test and test', category_id: 26, source_id: 1
    assert_not p.save
  end

  test "should detect short content" do
    p = Post.create title: 'This is a podst3', content: 'This is an exam', image: 'http://image.com/img', url: 'http://url.com/uri', category_id: 26, source_id: 1
    assert_not p.save
  end

  test "should run posts_for_index" do
    result = Post.posts_for_index
    assert_equal 2,result.count
  end

  test "should run posts for index with user" do
    result = Post.posts_for_index(1)
    assert_equal 2, result.count
  end
end
