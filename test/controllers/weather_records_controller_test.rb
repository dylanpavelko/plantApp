require 'test_helper'

class WeatherRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weather_record = weather_records(:one)
  end

  test "should get index" do
    get weather_records_url
    assert_response :success
  end

  test "should get new" do
    get new_weather_record_url
    assert_response :success
  end

  test "should create weather_record" do
    assert_difference('WeatherRecord.count') do
      post weather_records_url, params: { weather_record: { date: @weather_record.date, high_level_location_id: @weather_record.high_level_location_id, report: @weather_record.report } }
    end

    assert_redirected_to weather_record_url(WeatherRecord.last)
  end

  test "should show weather_record" do
    get weather_record_url(@weather_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_weather_record_url(@weather_record)
    assert_response :success
  end

  test "should update weather_record" do
    patch weather_record_url(@weather_record), params: { weather_record: { date: @weather_record.date, high_level_location_id: @weather_record.high_level_location_id, report: @weather_record.report } }
    assert_redirected_to weather_record_url(@weather_record)
  end

  test "should destroy weather_record" do
    assert_difference('WeatherRecord.count', -1) do
      delete weather_record_url(@weather_record)
    end

    assert_redirected_to weather_records_url
  end
end
