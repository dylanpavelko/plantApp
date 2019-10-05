require "application_system_test_case"

class WeatherRecordsTest < ApplicationSystemTestCase
  setup do
    @weather_record = weather_records(:one)
  end

  test "visiting the index" do
    visit weather_records_url
    assert_selector "h1", text: "Weather Records"
  end

  test "creating a Weather record" do
    visit weather_records_url
    click_on "New Weather Record"

    fill_in "Date", with: @weather_record.date
    fill_in "High level location", with: @weather_record.high_level_location_id
    fill_in "Report.text", with: @weather_record.report.text
    click_on "Create Weather record"

    assert_text "Weather record was successfully created"
    click_on "Back"
  end

  test "updating a Weather record" do
    visit weather_records_url
    click_on "Edit", match: :first

    fill_in "Date", with: @weather_record.date
    fill_in "High level location", with: @weather_record.high_level_location_id
    fill_in "Report.text", with: @weather_record.report.text
    click_on "Update Weather record"

    assert_text "Weather record was successfully updated"
    click_on "Back"
  end

  test "destroying a Weather record" do
    visit weather_records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Weather record was successfully destroyed"
  end
end
