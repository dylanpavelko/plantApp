require 'test_helper'

class WaterRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @water_record = water_records(:one)
  end

  test "should get index" do
    get water_records_url
    assert_response :success
  end

  test "should get new" do
    get new_water_record_url
    assert_response :success
  end

  test "should create water_record" do
    assert_difference('WaterRecord.count') do
      post water_records_url, params: { water_record: { moment: @water_record.moment, ounces: @water_record.ounces, plant_instance_id: @water_record.plant_instance_id } }
    end

    assert_redirected_to water_record_url(WaterRecord.last)
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
    assert_redirected_to water_record_url(@water_record)
  end

  test "should destroy water_record" do
    assert_difference('WaterRecord.count', -1) do
      delete water_record_url(@water_record)
    end

    assert_redirected_to water_records_url
  end
end
