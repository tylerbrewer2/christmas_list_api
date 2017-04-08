require 'test_helper'

# rubocop:disable Metrics/ClassLength
class ListsControllerTest < ActionDispatch::IntegrationTest
  describe 'index' do
    it 'should return all lists if queried by group' do
      get group_lists_path('1')

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data'].length, 2
    end

    it 'should return all lists if queried by user' do
      get user_lists_path('1')

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data'].length, 1
    end
  end

  describe 'show' do
    it 'should return the list if it is found' do
      get list_path('1')

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data']['group_id'], 1
    end

    it 'should return an error if the list is not found' do
      get list_path('23')

      json_response = JSON.parse(response.body)

      assert_response :bad_request
      assert_equal json_response['data'], 'There was an issue with your request: List not found'
    end
  end

  describe 'create' do
    it 'should return a list if successfully created from the users route' do
      post '/users/1/lists',
           params: {
             list: {
               user_id: '1',
               group_id: '1'
             }
           }

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data']['group_id'], 1
      assert_equal json_response['data']['user_id'], 1
    end

    it 'should return a list if successfully created from the groups route' do
      post '/groups/1/lists',
           params: {
             list: {
               user_id: '1',
               group_id: '1'
             }
           }

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data']['group_id'], 1
      assert_equal json_response['data']['user_id'], 1
    end

    it 'should return a response with errors if the list was not saved' do
      post '/groups/1/lists',
           params: {
             list: {
               user_id: '1'
             }
           }

      json_response = JSON.parse(response.body)

      assert_response :bad_request
      assert_equal json_response['data'], 'There was an issue with your request: Group must exist'
    end
  end

  describe 'update' do
    it 'should return a list if successfully updated' do
      patch '/lists/1',
            params: {
              list: {
                group_id: '2'
              }
            }

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data']['group_id'], 2
    end

    it 'should return an error if list was not successfully updated' do
      patch '/lists/1',
            params: {
              list: {
                user_id: ''
              }
            }

      json_response = JSON.parse(response.body)

      assert_response :bad_request
      assert_equal json_response['data'], 'There was an issue with your request: User must exist'
    end
  end

  describe 'destroy' do
    it 'should return a success message if the list was successfully deleted' do
      delete '/lists/1'

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data'], 'Successfully deleted list'
    end

    it 'should return an error message if the list cannot be found' do
      delete '/lists/23'

      json_response = JSON.parse(response.body)

      assert_response :bad_request
      assert_equal json_response['data'], 'There was an issue with your request: List not found'
    end
  end
end
