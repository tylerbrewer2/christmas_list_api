require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  describe 'validations' do
    it 'can be created with valid attributes' do
      group = Group.new(
        name: 'Group Name'
      )

      assert group.valid?, group.errors.full_messages
    end

    it 'cannot be created without a name' do
      group = Group.new

      refute group.valid?, 'Expected group to not be created without a name'
    end
  end
end
