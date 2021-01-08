require "application_system_test_case"

class BbchStagesTest < ApplicationSystemTestCase
  setup do
    @bbch_stage = bbch_stages(:one)
  end

  test "visiting the index" do
    visit bbch_stages_url
    assert_selector "h1", text: "Bbch Stages"
  end

  test "creating a Bbch stage" do
    visit bbch_stages_url
    click_on "New Bbch Stage"

    fill_in "Bbch profile", with: @bbch_stage.bbch_profile_id
    fill_in "Code", with: @bbch_stage.code
    fill_in "Description", with: @bbch_stage.description
    fill_in "Note", with: @bbch_stage.note
    click_on "Create Bbch stage"

    assert_text "Bbch stage was successfully created"
    click_on "Back"
  end

  test "updating a Bbch stage" do
    visit bbch_stages_url
    click_on "Edit", match: :first

    fill_in "Bbch profile", with: @bbch_stage.bbch_profile_id
    fill_in "Code", with: @bbch_stage.code
    fill_in "Description", with: @bbch_stage.description
    fill_in "Note", with: @bbch_stage.note
    click_on "Update Bbch stage"

    assert_text "Bbch stage was successfully updated"
    click_on "Back"
  end

  test "destroying a Bbch stage" do
    visit bbch_stages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Bbch stage was successfully destroyed"
  end
end
