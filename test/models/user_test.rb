require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'should create an user' do
    u = User.create username: 'sergio', password: '123', password_confirmation: '123'
    assert u.save

    user = User.find_by id: u.id
  end

  test 'should detect different passwords' do
    u = User.create username: 'sergio', password: '123', password_confirmation: '3211'
    assert_not u.save
  end

  test 'should autenticate users' do
    u = User.authenticate 'pepe', 'password'
    assert_not_nil u
  end
end
