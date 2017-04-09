require 'test_helper'

module Response
  class BaseTest < ActiveSupport::TestCase
    describe '#response' do
      it 'returns a correctly formatted response when a string is received' do
        response = Response::Error.new('Test').response

        assert_equal response[:json][:data], 'There was an issue with your request: Test'
        assert_equal response[:status], :bad_request
      end

      it 'returns a correctly formatted response when an array is received' do
        response = Response::Error.new(%w(Test Message)).response

        assert_equal response[:json][:data], 'There was an issue with your request: Test, Message'
        assert_equal response[:status], :bad_request
      end
    end
  end
end
