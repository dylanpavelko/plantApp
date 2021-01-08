require "application_system_test_case"

class GrowthObservationsTest < ApplicationSystemTestCase
  setup do
    @growth_observation = growth_observations(:one)
  end

  test "visiting the index" do
    visit growth_observations_url
    assert_selector "h1", text: "Growth Observations"
  end

  test "creating a Growth observation" do
    visit growth_observations_url
    click_on "New Growth Observation"

    fill_in "Bbch stage", with: @growth_observation.bbch_stage_id
    fill_in "Observation date", with: @growth_observation.observation_date
    fill_in "Percent at stage", with: @growth_observation.percent_at_stage
    fill_in "Plant instance", with: @growth_observation.plant_instance_id
    click_on "Create Growth observation"

    assert_text "Growth observation was successfully created"
    click_on "Back"
  end

  test "updating a Growth observation" do
    visit growth_observations_url
    click_on "Edit", match: :first

    fill_in "Bbch stage", with: @growth_observation.bbch_stage_id
    fill_in "Observation date", with: @growth_observation.observation_date
    fill_in "Percent at stage", with: @growth_observation.percent_at_stage
    fill_in "Plant instance", with: @growth_observation.plant_instance_id
    click_on "Update Growth observation"

    assert_text "Growth observation was successfully updated"
    click_on "Back"
  end

  test "destroying a Growth observation" do
    visit growth_observations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Growth observation was successfully destroyed"
  end
end
