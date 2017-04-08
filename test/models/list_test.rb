require 'test_helper'

class ListTest < ActiveSupport::TestCase
  describe 'validations' do
    it 'can be created with valid attributes' do
      list = List.new
      list.group = FactoryGirl.create(:group)
      list.user = FactoryGirl.create(:user)
    end
  end
end
