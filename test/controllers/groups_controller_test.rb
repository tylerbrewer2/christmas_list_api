require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  describe 'index' do
    it 'should return all groups' do
      get groups_path

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data'].length, 2
    end
  end

  describe 'show' do
    it 'should return the group if it is found' do
      get group_path('1')

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data']['name'], 'Cool Group'
    end

    it 'should return an error if the group is not found' do
      get group_path('23')

      json_response = JSON.parse(response.body)

      assert_response :bad_request
      assert_equal json_response['data'], 'There was an issue with your request: Group not found'
    end
  end

  describe 'create' do
    it 'should return a group if successfully created' do
      post '/groups',
           params: {
             group: {
               name: 'Hogwarts School of Witchcraft and Wizardry'
             }
           }

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data']['name'], 'Hogwarts School of Witchcraft and Wizardry'
    end

    it 'should return a response with errors if the group was not saved' do
      post '/groups',
           params: {
             group: {
               name: ''
             }
           }

      json_response = JSON.parse(response.body)

      assert_response :bad_request
      assert_equal json_response['data'], 'There was an issue with your request: Name can\'t be blank'
    end
  end

  describe 'update' do
    it 'should return a group if successfully updated' do
      patch '/groups/1',
            params: {
              group: {
                name: 'Dublin Jerome High School'
              }
            }

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data']['name'], 'Dublin Jerome High School'
    end

    it 'should return an error if group was not successfully updated' do
      patch '/groups/1',
            params: {
              group: {
                name: ''
              }
            }

      json_response = JSON.parse(response.body)

      assert_response :bad_request
      assert_equal json_response['data'], 'There was an issue with your request: Name can\'t be blank'
    end
  end

  describe 'destroy' do
    it 'should return a success message if the group was successfully deleted' do
      delete '/groups/1'

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data'], 'Successfully deleted group'
    end

    it 'should return an error message if the group cannot be found' do
      delete '/groups/23'

      json_response = JSON.parse(response.body)

      assert_response :bad_request
      assert_equal json_response['data'], 'There was an issue with your request: Group not found'
    end
  end
end
