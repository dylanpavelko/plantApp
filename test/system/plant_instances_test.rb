require "application_system_test_case"

class PlantInstancesTest < ApplicationSystemTestCase
  setup do
    @plant_instance = plant_instances(:one)
  end

  test "visiting the index" do
    visit plant_instances_url
    assert_selector "h1", text: "Plant Instances"
  end

  test "creating a Plant instance" do
    visit plant_instances_url
    click_on "New Plant Instance"

    fill_in "Location", with: @plant_instance.location_id
    fill_in "Plant", with: @plant_instance.plant_id
    click_on "Create Plant instance"

    assert_text "Plant instance was successfully created"
    click_on "Back"
  end

  test "updating a Plant instance" do
    visit plant_instances_url
    click_on "Edit", match: :first

    fill_in "Location", with: @plant_instance.location_id
    fill_in "Plant", with: @plant_instance.plant_id
    click_on "Update Plant instance"

    assert_text "Plant instance was successfully updated"
    click_on "Back"
  end

  test "destroying a Plant instance" do
    visit plant_instances_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Plant instance was successfully destroyed"
  end
end
