require 'test_helper'

module Response
  class BaseTest < ActiveSupport::TestCase
    describe 'initialization' do
      it 'is created with a data method' do
        response = Response::Base.new('Test')

        assert_equal response.data, 'Test'
      end
    end
  end
end
