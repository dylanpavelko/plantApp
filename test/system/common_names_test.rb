require "application_system_test_case"

class CommonNamesTest < ApplicationSystemTestCase
  setup do
    @common_name = common_names(:one)
  end

  test "visiting the index" do
    visit common_names_url
    assert_selector "h1", text: "Common Names"
  end

  test "creating a Common name" do
    visit common_names_url
    click_on "New Common Name"

    fill_in "Name", with: @common_name.name
    fill_in "Plant", with: @common_name.plant_id
    click_on "Create Common name"

    assert_text "Common name was successfully created"
    click_on "Back"
  end

  test "updating a Common name" do
    visit common_names_url
    click_on "Edit", match: :first

    fill_in "Name", with: @common_name.name
    fill_in "Plant", with: @common_name.plant_id
    click_on "Update Common name"

    assert_text "Common name was successfully updated"
    click_on "Back"
  end

  test "destroying a Common name" do
    visit common_names_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Common name was successfully destroyed"
  end
end
