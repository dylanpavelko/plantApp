require "application_system_test_case"

class CultivatorsTest < ApplicationSystemTestCase
  setup do
    @cultivator = cultivators(:one)
  end

  test "visiting the index" do
    visit cultivators_url
    assert_selector "h1", text: "Cultivators"
  end

  test "creating a Cultivator" do
    visit cultivators_url
    click_on "New Cultivator"

    fill_in "Description", with: @cultivator.description
    fill_in "Name", with: @cultivator.name
    fill_in "Species", with: @cultivator.species_id
    click_on "Create Cultivator"

    assert_text "Cultivator was successfully created"
    click_on "Back"
  end

  test "updating a Cultivator" do
    visit cultivators_url
    click_on "Edit", match: :first

    fill_in "Description", with: @cultivator.description
    fill_in "Name", with: @cultivator.name
    fill_in "Species", with: @cultivator.species_id
    click_on "Update Cultivator"

    assert_text "Cultivator was successfully updated"
    click_on "Back"
  end

  test "destroying a Cultivator" do
    visit cultivators_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cultivator was successfully destroyed"
  end
end
