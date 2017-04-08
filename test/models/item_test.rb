require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  before do
    @list = FactoryGirl.create(:list)
  end
  describe 'validations' do
    it 'can be created with valid attributes' do
      item = Item.new(
        name: 'Canyon Bike',
        url: 'https://www.canyon.com',
        price: 10_000.00
      )
      item.list = @list

      assert item.valid?, item.errors.full_messages
    end

    it 'cannot be created without a name' do
      item = Item.new(
        url: 'https://www.canyon.com',
        price: 10_000.00
      )
      item.list = @list

      refute item.valid?, 'Expected Item to not be valid without a name'
    end

    it 'cannot be created without a url' do
      item = Item.new(
        name: 'Canyon Bike',
        price: 10_000.00
      )
      item.list = @list

      refute item.valid?, 'Expected Item to not be valid without a url'
    end

    it 'cannot be created without a correctly formatted url' do
      item = Item.new(
        name: 'Canyon Bike',
        url: 'canyon.com',
        price: 10_000.00
      )
      item.list = @list

      refute item.valid?, 'Expected Item to not be valid without a correctly formatted url'
    end

    it 'can be created with a correctly formatted url' do
      item_with_https = Item.new(
        name: 'Canyon Bike',
        url: 'https://www.canyon.com',
        price: 10_000.00
      )
      item_with_https.list = @list

      item_with_http = Item.new(
        name: 'Canyon Bike',
        url: 'http://www.canyon.com',
        price: 10_000.00
      )
      item_with_http.list = @list

      assert item_with_https.valid?, 'Expected Item to be valid without a correctly formatted url (https)'
      assert item_with_http.valid?, 'Expected Item to be valid without a correctly formatted url (http)'
    end
  end
end
