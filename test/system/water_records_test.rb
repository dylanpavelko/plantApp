require "application_system_test_case"

class WaterRecordsTest < ApplicationSystemTestCase
  setup do
    @water_record = water_records(:one)
  end

  test "visiting the index" do
    visit water_records_url
    assert_selector "h1", text: "Water Records"
  end

  test "creating a Water record" do
    visit water_records_url
    click_on "New Water Record"

    fill_in "Moment", with: @water_record.moment
    fill_in "Ounces", with: @water_record.ounces
    fill_in "Plant instance", with: @water_record.plant_instance_id
    click_on "Create Water record"

    assert_text "Water record was successfully created"
    click_on "Back"
  end

  test "updating a Water record" do
    visit water_records_url
    click_on "Edit", match: :first

    fill_in "Moment", with: @water_record.moment
    fill_in "Ounces", with: @water_record.ounces
    fill_in "Plant instance", with: @water_record.plant_instance_id
    click_on "Update Water record"

    assert_text "Water record was successfully updated"
    click_on "Back"
  end

  test "destroying a Water record" do
    visit water_records_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Water record was successfully destroyed"
  end
end
