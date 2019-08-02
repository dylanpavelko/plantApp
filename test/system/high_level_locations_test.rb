require "application_system_test_case"

class HighLevelLocationsTest < ApplicationSystemTestCase
  setup do
    @high_level_location = high_level_locations(:one)
  end

  test "visiting the index" do
    visit high_level_locations_url
    assert_selector "h1", text: "High Level Locations"
  end

  test "creating a High level location" do
    visit high_level_locations_url
    click_on "New High Level Location"

    fill_in "Name", with: @high_level_location.name
    fill_in "Zip", with: @high_level_location.zip
    click_on "Create High level location"

    assert_text "High level location was successfully created"
    click_on "Back"
  end

  test "updating a High level location" do
    visit high_level_locations_url
    click_on "Edit", match: :first

    fill_in "Name", with: @high_level_location.name
    fill_in "Zip", with: @high_level_location.zip
    click_on "Update High level location"

    assert_text "High level location was successfully updated"
    click_on "Back"
  end

  test "destroying a High level location" do
    visit high_level_locations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "High level location was successfully destroyed"
  end
end
