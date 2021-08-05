require 'test_helper'

class GrowthStagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @growth_stage = growth_stages(:one)
  end

  test "should get index" do
    get growth_stages_url
    assert_response :success
  end

  test "should get new" do
    get new_growth_stage_url(:species_id => @growth_stage.species_id)
    assert_response :success
  end

  test "should create growth_stage" do
    assert_difference('GrowthStage.count') do
      post growth_stages_url, params: { growth_stage: { bbch_code: @growth_stage.bbch_code, cold_damage_risk: @growth_stage.cold_damage_risk, from_bbch_code: @growth_stage.from_bbch_code, growth_base: @growth_stage.growth_base, growth_cutoff: @growth_stage.growth_cutoff, harvestable: @growth_stage.harvestable, heat_damage_risk: @growth_stage.heat_damage_risk, min_agdd: @growth_stage.min_agdd, min_days: @growth_stage.min_days, required_high: @growth_stage.required_high, required_low: @growth_stage.required_low, species_id: @growth_stage.species_id } }
    end

    assert_redirected_to growth_stage_url(GrowthStage.last)
  end

  test "should show growth_stage" do
    get growth_stage_url(@growth_stage)
    assert_response :success
  end

  test "should get edit" do
    get edit_growth_stage_url(@growth_stage)
    assert_response :success
  end

  test "should update growth_stage" do
    patch growth_stage_url(@growth_stage), params: { growth_stage: { bbch_code: @growth_stage.bbch_code, cold_damage_risk: @growth_stage.cold_damage_risk, from_bbch_code: @growth_stage.from_bbch_code, growth_base: @growth_stage.growth_base, growth_cutoff: @growth_stage.growth_cutoff, harvestable: @growth_stage.harvestable, heat_damage_risk: @growth_stage.heat_damage_risk, min_agdd: @growth_stage.min_agdd, min_days: @growth_stage.min_days, required_high: @growth_stage.required_high, required_low: @growth_stage.required_low, species_id: @growth_stage.species_id } }
    assert_redirected_to growth_stage_url(@growth_stage)
  end

  test "should destroy growth_stage" do
    assert_difference('GrowthStage.count', -1) do
      delete growth_stage_url(@growth_stage)
    end

    assert_redirected_to growth_stages_url
  end
end
