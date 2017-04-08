require 'test_helper'

class UserTest < ActiveSupport::TestCase
  describe 'validations' do
    it 'can be created with valid attributes' do
      user = User.new(
        first_name: 'Tyler',
        last_name: 'Brewer',
        email: 'test@email.com'
      )

      assert user.valid?, user.errors.full_messages
    end

    it 'cannot be created without a first name' do
      user = User.new(
        last_name: 'Brewer',
        email: 'test@email.com'
      )

      refute user.valid?, 'Expected user to not be created without a first name'
    end

    it 'cannot be created without an email' do
      user = User.new(
        first_name: 'Tyler',
        last_name: 'Brewer'
      )

      refute user.valid?, 'Expected user to not be created without an email'
    end
  end
end
