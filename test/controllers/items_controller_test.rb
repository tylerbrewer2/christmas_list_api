require 'test_helper'

# rubocop:disable Metrics/ClassLength
class ItemsControllerTest < ActionDispatch::IntegrationTest
  describe 'index' do
    it 'should return all items if queried by group' do
      get group_items_path('1')

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data'].length, 5
    end

    it 'should return all lists if queried by user' do
      get user_items_path('1')

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data'].length, 5
    end
  end

  describe 'show' do
    it 'should return the item if it is found' do
      get item_path('1')

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data']['name'], 'Item #0'
      assert_equal json_response['data']['url'], 'https://tylerbrewerdesign.com'
      assert_equal json_response['data']['price'], '100.0'
      assert_equal json_response['data']['list_id'], 1
    end

    it 'should return an error if the item is not found' do
      get item_path('23')

      json_response = JSON.parse(response.body)

      assert_response :bad_request
      assert_equal json_response['data'], 'There was an issue with your request: Item not found'
    end
  end

  describe 'create' do
    it 'should return an item if successfully created from the users route' do
      post '/users/1/items',
           params: {
             item: {
               name: 'Test Name',
               url: 'https://tylerbrewerdesign.com',
               price: '100.0',
               list_id: '1'
             }
           }

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data']['name'], 'Test Name'
      assert_equal json_response['data']['url'], 'https://tylerbrewerdesign.com'
      assert_equal json_response['data']['price'], '100.0'
      assert_equal json_response['data']['list_id'], 1
    end

    it 'should return an item if successfully created from the groups route' do
      post '/groups/1/items',
           params: {
             item: {
               name: 'Test Name 2',
               url: 'https://tylerbrewerdesign.com',
               price: '100.0',
               list_id: '1'
             }
           }

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data']['name'], 'Test Name 2'
      assert_equal json_response['data']['url'], 'https://tylerbrewerdesign.com'
      assert_equal json_response['data']['price'], '100.0'
      assert_equal json_response['data']['list_id'], 1
    end

    it 'should return a response with errors if the item was not saved' do
      post '/groups/1/items',
           params: {
             item: {
               url: 'https://tylerbrewerdesign.com',
               price: '100.0',
               list_id: '1'
             }
           }

      json_response = JSON.parse(response.body)

      assert_response :bad_request
      assert_equal json_response['data'], 'There was an issue with your request: Name can\'t be blank'
    end
  end

  describe 'update' do
    it 'should return an item if successfully updated' do
      patch '/items/1',
            params: {
              item: {
                name: 'New Name'
              }
            }

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data']['name'], 'New Name'
      assert_equal json_response['data']['url'], 'https://tylerbrewerdesign.com'
      assert_equal json_response['data']['price'], '100.0'
      assert_equal json_response['data']['list_id'], 1
    end

    it 'should return an error if list was not successfully updated' do
      patch '/items/1',
            params: {
              item: {
                name: ''
              }
            }

      json_response = JSON.parse(response.body)

      assert_response :bad_request
      assert_equal json_response['data'], 'There was an issue with your request: Name can\'t be blank'
    end
  end

  describe 'destroy' do
    it 'should return a success message if the item was successfully deleted' do
      delete '/items/1'

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data'], 'Successfully deleted item'
    end

    it 'should return an error message if the item cannot be found' do
      delete '/items/23'

      json_response = JSON.parse(response.body)

      assert_response :bad_request
      assert_equal json_response['data'], 'There was an issue with your request: Item not found'
    end
  end
end
