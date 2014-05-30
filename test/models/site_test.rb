require 'test_helper'

class SiteTest < ActiveSupport::TestCase

  test "should create a site" do
    s = Site.create name: 'site1', url: 'http://site1.com'
    assert s.save
  end

  test "should not create a site" do
    s = Site.create name: 'site2'
    assert_not s.save

    s = Site.create name: 'site2', url: 'ds'
    assert_not s.save
  end
end
