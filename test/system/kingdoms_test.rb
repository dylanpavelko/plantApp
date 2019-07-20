require "application_system_test_case"

class KingdomsTest < ApplicationSystemTestCase
  setup do
    @kingdom = kingdoms(:one)
  end

  test "visiting the index" do
    visit kingdoms_url
    assert_selector "h1", text: "Kingdoms"
  end

  test "creating a Kingdom" do
    visit kingdoms_url
    click_on "New Kingdom"

    fill_in "Description", with: @kingdom.description
    fill_in "Name", with: @kingdom.name
    click_on "Create Kingdom"

    assert_text "Kingdom was successfully created"
    click_on "Back"
  end

  test "updating a Kingdom" do
    visit kingdoms_url
    click_on "Edit", match: :first

    fill_in "Description", with: @kingdom.description
    fill_in "Name", with: @kingdom.name
    click_on "Update Kingdom"

    assert_text "Kingdom was successfully updated"
    click_on "Back"
  end

  test "destroying a Kingdom" do
    visit kingdoms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Kingdom was successfully destroyed"
  end
end
