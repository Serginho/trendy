require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  test "should create category" do
    c = Category.create name: 'category', description: 'that\'s an example of category description'
    c.save!
    assert_not c.id.nil?
  end

  test "should not create category"  do
    c = Category.create name:'with spaces'
    assert_not c.save
    c = Category.create name: 'trululu', description:'short'
    assert_not c.save
  end

end
