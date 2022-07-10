require 'test_helper'
require_relative '../helpers/authorization_helper'

class CultivatorsControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @cultivator = cultivators(:one)
    test_user = { email: 'userone@test.com', password: 'password', admin: true }
    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)
  end

  test "should get index" do
    get cultivators_url
    assert_response :success
  end

  test "should get new" do
    get new_cultivator_url
    assert_response :success
  end

  test "should create cultivator" do
    assert_difference('Cultivator.count') do
      post cultivators_url, params: { cultivator: { description: @cultivator.description, name: @cultivator.name, species_id: @cultivator.species_id } }
    end

    assert_redirected_to plant_url(Plant.last)
  end

  test "should show cultivator" do
    get cultivator_url(@cultivator)
    assert_response :success
  end

  test "should get edit" do
    get edit_cultivator_url(@cultivator)
    assert_response :success
  end

  test "should update cultivator" do
    patch cultivator_url(@cultivator), params: { cultivator: { description: @cultivator.description, name: @cultivator.name, species_id: @cultivator.species_id } }
    assert_redirected_to cultivator_url(@cultivator)
  end

  test "should destroy cultivator" do
    assert_difference('Cultivator.count', -1) do
      delete cultivator_url(@cultivator)
    end

    assert_redirected_to cultivators_url
  end
end
