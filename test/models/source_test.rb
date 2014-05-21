require 'test_helper'

class SourceTest < ActiveSupport::TestCase
  test 'should create source' do
    s = Source.create name: 'source1', url: 'http://source.com'
    assert s.save
  end

  test 'check data required' do
    s = Source.create name: 'source2'
    assert_not s.save

    s = Source.create url: 'http://source.com'
    assert_not s.save
  end

  test 'should valid url' do
    s = Source.create name: 'source3', url: 'bad_url'
    assert_not s.save

    s = Source.create name: 'source3', url: 'http//sdfsd'
    assert_not s.save
  end
end
