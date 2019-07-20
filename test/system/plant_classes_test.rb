require "application_system_test_case"

class PlantClassesTest < ApplicationSystemTestCase
  setup do
    @plant_class = plant_classes(:one)
  end

  test "visiting the index" do
    visit plant_classes_url
    assert_selector "h1", text: "Plant Classes"
  end

  test "creating a Plant class" do
    visit plant_classes_url
    click_on "New Plant Class"

    fill_in "Description", with: @plant_class.description
    fill_in "Name", with: @plant_class.name
    click_on "Create Plant class"

    assert_text "Plant class was successfully created"
    click_on "Back"
  end

  test "updating a Plant class" do
    visit plant_classes_url
    click_on "Edit", match: :first

    fill_in "Description", with: @plant_class.description
    fill_in "Name", with: @plant_class.name
    click_on "Update Plant class"

    assert_text "Plant class was successfully updated"
    click_on "Back"
  end

  test "destroying a Plant class" do
    visit plant_classes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Plant class was successfully destroyed"
  end
end
