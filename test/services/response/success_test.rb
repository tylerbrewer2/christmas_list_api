require 'test_helper'

module Response
  class BaseTest < ActiveSupport::TestCase
    describe '#response' do
      it 'returns a correctly formatted response' do
        response = Response::Success.new(user: { name: 'Tyler' }).response

        assert_equal response[:json][:data], user: { name: 'Tyler' }
        assert_equal response[:status], :ok
      end
    end
  end
end
