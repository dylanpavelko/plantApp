require "application_system_test_case"

class GenusTest < ApplicationSystemTestCase
  setup do
    @genu = genus(:one)
  end

  test "visiting the index" do
    visit genus_url
    assert_selector "h1", text: "Genus"
  end

  test "creating a Genu" do
    visit genus_url
    click_on "New Genu"

    fill_in "Description", with: @genu.description
    fill_in "Name", with: @genu.name
    click_on "Create Genu"

    assert_text "Genu was successfully created"
    click_on "Back"
  end

  test "updating a Genu" do
    visit genus_url
    click_on "Edit", match: :first

    fill_in "Description", with: @genu.description
    fill_in "Name", with: @genu.name
    click_on "Update Genu"

    assert_text "Genu was successfully updated"
    click_on "Back"
  end

  test "destroying a Genu" do
    visit genus_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Genu was successfully destroyed"
  end
end
