require 'test_helper'

class WeatherAveragesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @weather_average = weather_averages(:one)
  end

  test "should get index" do
    get weather_averages_url
    assert_response :success
  end

  test "should get new" do
    get new_weather_average_url
    assert_response :success
  end

  test "should create weather_average" do
    assert_difference('WeatherAverage.count') do
      post weather_averages_url, params: { weather_average: { day: @weather_average.day, high_level_location_id: @weather_average.high_level_location_id, max_t_std_dev: @weather_average.max_t_std_dev, max_temp_f: @weather_average.max_temp_f, min_t_std_dev: @weather_average.min_t_std_dev, min_temp_f: @weather_average.min_temp_f, precip_in: @weather_average.precip_in, precip_std_dev: @weather_average.precip_std_dev } }
    end

    assert_redirected_to weather_average_url(WeatherAverage.last)
  end

  test "should show weather_average" do
    get weather_average_url(@weather_average)
    assert_response :success
  end

  test "should get edit" do
    get edit_weather_average_url(@weather_average)
    assert_response :success
  end

  test "should update weather_average" do
    patch weather_average_url(@weather_average), params: { weather_average: { day: @weather_average.day, high_level_location_id: @weather_average.high_level_location_id, max_t_std_dev: @weather_average.max_t_std_dev, max_temp_f: @weather_average.max_temp_f, min_t_std_dev: @weather_average.min_t_std_dev, min_temp_f: @weather_average.min_temp_f, precip_in: @weather_average.precip_in, precip_std_dev: @weather_average.precip_std_dev } }
    assert_redirected_to weather_average_url(@weather_average)
  end

  test "should destroy weather_average" do
    assert_difference('WeatherAverage.count', -1) do
      delete weather_average_url(@weather_average)
    end

    assert_redirected_to weather_averages_url
  end
end
