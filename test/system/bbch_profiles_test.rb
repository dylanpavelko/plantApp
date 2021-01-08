require "application_system_test_case"

class BbchProfilesTest < ApplicationSystemTestCase
  setup do
    @bbch_profile = bbch_profiles(:one)
  end

  test "visiting the index" do
    visit bbch_profiles_url
    assert_selector "h1", text: "Bbch Profiles"
  end

  test "creating a Bbch profile" do
    visit bbch_profiles_url
    click_on "New Bbch Profile"

    fill_in "Name", with: @bbch_profile.name
    click_on "Create Bbch profile"

    assert_text "Bbch profile was successfully created"
    click_on "Back"
  end

  test "updating a Bbch profile" do
    visit bbch_profiles_url
    click_on "Edit", match: :first

    fill_in "Name", with: @bbch_profile.name
    click_on "Update Bbch profile"

    assert_text "Bbch profile was successfully updated"
    click_on "Back"
  end

  test "destroying a Bbch profile" do
    visit bbch_profiles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bbch profile was successfully destroyed"
  end
end
