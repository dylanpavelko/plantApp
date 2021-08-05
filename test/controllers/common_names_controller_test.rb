require 'test_helper'
require_relative '../helpers/authorization_helper'

class CommonNamesControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @common_name = common_names(:one)
    test_user = { email: 'userone@test.com', password: 'password', admin: true }
    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)
  end

  test "should get index" do
    get common_names_url
    assert_response :success
  end

  test "should get new" do
    get new_common_name_url(plant_id: @common_name.plant)
    assert_response :success
  end

  test "should create common_name" do
    assert_difference('CommonName.count') do
      post common_names_url, params: { common_name: { name: @common_name.name, plant_id: @common_name.plant_id } }
    end

    assert_redirected_to common_name_url(CommonName.last)
  end

  test "should show common_name" do
    get common_name_url(@common_name)
    assert_response :success
  end

  test "should get edit" do
    get edit_common_name_url(@common_name)
    assert_response :success
  end

  test "should update common_name" do
    patch common_name_url(@common_name), params: { common_name: { name: @common_name.name, plant_id: @common_name.plant_id } }
    assert_redirected_to common_name_url(@common_name)
  end

  test "should destroy common_name" do
    assert_difference('CommonName.count', -1) do
      delete common_name_url(@common_name)
    end

    assert_redirected_to common_names_url
  end
end
