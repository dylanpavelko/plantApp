require 'test_helper'
require_relative '../helpers/authorization_helper'

class WaterRecordsControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @water_record = water_records(:one)
    test_user = { email: 'userone@test.com', password: 'password', admin: true }
    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)
  end

  test "should get index" do
    get water_records_url
    assert_response :success
  end

  test "should get new" do
    get new_water_record_url(plant_instance_id: @water_record.plant_instance)
    assert_response :success
  end

  test "should create water_record" do
    assert_difference('WaterRecord.count') do
      post water_records_url, params: { water_record: { moment: @water_record.moment, ounces: @water_record.ounces, plant_instance_id: @water_record.plant_instance_id } }
    end

    assert_redirected_to plant_instance_url(@water_record.plant_instance)
  end

  test "should show water_record" do
    get water_record_url(@water_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_water_record_url(@water_record)
    assert_response :success
  end

  test "should update water_record" do
    patch water_record_url(@water_record), params: { water_record: { moment: @water_record.moment, ounces: @water_record.ounces, plant_instance_id: @water_record.plant_instance_id } }
    assert_redirected_to plant_instance_url(@water_record.plant_instance)
  end

  test "should destroy water_record" do
    assert_difference('WaterRecord.count', -1) do
      delete water_record_url(@water_record)
    end

    assert_redirected_to water_records_url
  end
end
