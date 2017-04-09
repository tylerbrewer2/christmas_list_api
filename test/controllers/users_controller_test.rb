require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  describe 'index' do
    it 'should return all users' do
      get users_path

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data'].length, 2
    end
  end

  describe 'show' do
    it 'should return the user if it is found' do
      get user_path('1')

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data']['first_name'], 'Tyler'
      assert_equal json_response['data']['last_name'], 'Brewer'
      assert_equal json_response['data']['email'], 'tylerbrewer02@gmail.com'
    end

    it 'should return an error if the user is not found' do
      get user_path('23')

      json_response = JSON.parse(response.body)

      assert_response :bad_request
      assert_equal json_response['data'], 'There was an issue with your request: User not found'
    end
  end

  describe 'create' do
    it 'should return a user if successfully created' do
      post '/users',
           params: {
             user: {
               first_name: 'Ron',
               last_name: 'Weasley',
               email: 'ronald_weasley@hogwarts.edu'
             }
           }

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data']['first_name'], 'Ron'
      assert_equal json_response['data']['last_name'], 'Weasley'
      assert_equal json_response['data']['email'], 'ronald_weasley@hogwarts.edu'
    end

    it 'should return a response with errors if the user was not saved' do
      post '/users',
           params: {
             user: {
               last_name: 'Granger',
               email: 'hermione_granger@hogwarts.edu'
             }
           }

      json_response = JSON.parse(response.body)

      assert_response :bad_request
      assert_equal json_response['data'], 'There was an issue with your request: First name can\'t be blank'
    end
  end

  describe 'update' do
    it 'should return a user if successfully updated' do
      patch '/users/1',
            params: {
              user: {
                first_name: 'Bob'
              }
            }

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data']['first_name'], 'Bob'
      assert_equal json_response['data']['last_name'], 'Brewer'
      assert_equal json_response['data']['email'], 'tylerbrewer02@gmail.com'
    end

    it 'should return an error if user was not successfully updated' do
      patch '/users/1',
            params: {
              user: {
                first_name: ''
              }
            }

      json_response = JSON.parse(response.body)

      assert_response :bad_request
      assert_equal json_response['data'], 'There was an issue with your request: First name can\'t be blank'
    end
  end

  describe 'destroy' do
    it 'should return a success message if the user was successfully deleted' do
      delete '/users/1'

      json_response = JSON.parse(response.body)

      assert_response :success
      assert_equal json_response['data'], 'Successfully deleted user'
    end

    it 'should return an error message if the user cannot be found' do
      delete '/users/23'

      json_response = JSON.parse(response.body)

      assert_response :bad_request
      assert_equal json_response['data'], 'There was an issue with your request: User not found'
    end
  end
end
