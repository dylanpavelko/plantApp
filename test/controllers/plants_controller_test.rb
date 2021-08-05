require 'test_helper'
require_relative '../helpers/authorization_helper'

class PlantsControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @plant = plants(:one)
    test_user = { email: 'userone@test.com', password: 'password', admin: true }
    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)
  end

  test "should get index" do
    get plants_url
    assert_response :success
  end

  test "should get new" do
    get new_plant_url
    assert_response :success
  end

  test "should create plant" do
    assert_difference('Plant.count') do
      post plants_url, params: { plant: { species_id: @plant.species_id, variety_id: @plant.variety_id } }
    end

    assert_redirected_to plant_url(Plant.last)
  end

  test "should show plant" do
    get plant_url(@plant)
    assert_response :success
  end

  test "should get edit" do
    get edit_plant_url(@plant)
    assert_response :success
  end

  test "should update plant" do
    patch plant_url(@plant), params: { plant: { species_id: @plant.species_id, variety_id: @plant.variety_id } }
    assert_redirected_to plant_url(@plant)
  end

  test "should destroy plant" do
    assert_difference('Plant.count', -1) do
      delete plant_url(@plant)
    end

    assert_redirected_to plants_url
  end
end
