require 'test_helper'
require_relative '../helpers/authorization_helper'

class HighLevelLocationsControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @high_level_location = high_level_locations(:one)
    test_user = { email: 'userone@test.com', password: 'password', admin: true }
    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)
  end

  test "should get index" do
    get high_level_locations_url
    assert_response :success
  end

  test "should get new" do
    get new_high_level_location_url
    assert_response :success
  end

  test "should create high_level_location" do
    @user = User.all.first
    assert_difference('HighLevelLocation.count') do
      post high_level_locations_url, params: { high_level_location: { name: @high_level_location.name, zip: @high_level_location.zip, user_id: @user.id } }
    end

    assert_redirected_to high_level_location_url(HighLevelLocation.last)
  end

  test "should show high_level_location" do
    get high_level_location_url(@high_level_location)
    assert_response :success
  end

  test "should get edit" do
    get edit_high_level_location_url(@high_level_location)
    assert_response :success
  end

  test "should update high_level_location" do
    patch high_level_location_url(@high_level_location), params: { high_level_location: { name: @high_level_location.name, zip: @high_level_location.zip } }
    assert_redirected_to high_level_location_url(@high_level_location)
  end

  test "should destroy high_level_location" do
    assert_difference('HighLevelLocation.count', -1) do
      delete high_level_location_url(@high_level_location)
    end

    assert_redirected_to high_level_locations_url
  end
end
