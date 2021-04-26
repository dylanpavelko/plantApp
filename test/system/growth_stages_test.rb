require "application_system_test_case"

class GrowthStagesTest < ApplicationSystemTestCase
  setup do
    @growth_stage = growth_stages(:one)
  end

  test "visiting the index" do
    visit growth_stages_url
    assert_selector "h1", text: "Growth Stages"
  end

  test "creating a Growth stage" do
    visit growth_stages_url
    click_on "New Growth Stage"

    fill_in "Bbch code", with: @growth_stage.bbch_code
    fill_in "Cold damage risk", with: @growth_stage.cold_damage_risk
    fill_in "From bbch code", with: @growth_stage.from_bbch_code
    fill_in "Growth base", with: @growth_stage.growth_base
    fill_in "Growth cutoff", with: @growth_stage.growth_cutoff
    check "Harvestable" if @growth_stage.harvestable
    fill_in "Heat damage risk", with: @growth_stage.heat_damage_risk
    fill_in "Min agdd", with: @growth_stage.min_agdd
    fill_in "Min days", with: @growth_stage.min_days
    fill_in "Required high", with: @growth_stage.required_high
    fill_in "Required low", with: @growth_stage.required_low
    fill_in "Species", with: @growth_stage.species_id
    click_on "Create Growth stage"

    assert_text "Growth stage was successfully created"
    click_on "Back"
  end

  test "updating a Growth stage" do
    visit growth_stages_url
    click_on "Edit", match: :first

    fill_in "Bbch code", with: @growth_stage.bbch_code
    fill_in "Cold damage risk", with: @growth_stage.cold_damage_risk
    fill_in "From bbch code", with: @growth_stage.from_bbch_code
    fill_in "Growth base", with: @growth_stage.growth_base
    fill_in "Growth cutoff", with: @growth_stage.growth_cutoff
    check "Harvestable" if @growth_stage.harvestable
    fill_in "Heat damage risk", with: @growth_stage.heat_damage_risk
    fill_in "Min agdd", with: @growth_stage.min_agdd
    fill_in "Min days", with: @growth_stage.min_days
    fill_in "Required high", with: @growth_stage.required_high
    fill_in "Required low", with: @growth_stage.required_low
    fill_in "Species", with: @growth_stage.species_id
    click_on "Update Growth stage"

    assert_text "Growth stage was successfully updated"
    click_on "Back"
  end

  test "destroying a Growth stage" do
    visit growth_stages_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Growth stage was successfully destroyed"
  end
end
