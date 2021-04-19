require "application_system_test_case"

class WeatherAveragesTest < ApplicationSystemTestCase
  setup do
    @weather_average = weather_averages(:one)
  end

  test "visiting the index" do
    visit weather_averages_url
    assert_selector "h1", text: "Weather Averages"
  end

  test "creating a Weather average" do
    visit weather_averages_url
    click_on "New Weather Average"

    fill_in "Day", with: @weather_average.day
    fill_in "High level location", with: @weather_average.high_level_location_id
    fill_in "Max t std dev", with: @weather_average.max_t_std_dev
    fill_in "Max temp f", with: @weather_average.max_temp_f
    fill_in "Min t std dev", with: @weather_average.min_t_std_dev
    fill_in "Min temp f", with: @weather_average.min_temp_f
    fill_in "Precip in", with: @weather_average.precip_in
    fill_in "Precip std dev", with: @weather_average.precip_std_dev
    click_on "Create Weather average"

    assert_text "Weather average was successfully created"
    click_on "Back"
  end

  test "updating a Weather average" do
    visit weather_averages_url
    click_on "Edit", match: :first

    fill_in "Day", with: @weather_average.day
    fill_in "High level location", with: @weather_average.high_level_location_id
    fill_in "Max t std dev", with: @weather_average.max_t_std_dev
    fill_in "Max temp f", with: @weather_average.max_temp_f
    fill_in "Min t std dev", with: @weather_average.min_t_std_dev
    fill_in "Min temp f", with: @weather_average.min_temp_f
    fill_in "Precip in", with: @weather_average.precip_in
    fill_in "Precip std dev", with: @weather_average.precip_std_dev
    click_on "Update Weather average"

    assert_text "Weather average was successfully updated"
    click_on "Back"
  end

  test "destroying a Weather average" do
    visit weather_averages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Weather average was successfully destroyed"
  end
end
