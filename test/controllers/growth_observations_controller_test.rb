require 'test_helper'

class GrowthObservationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @growth_observation = growth_observations(:one)
  end

  test "should get index" do
    get growth_observations_url
    assert_response :success
  end

  test "should get new" do
    get new_growth_observation_url
    assert_response :success
  end

  test "should create growth_observation" do
    assert_difference('GrowthObservation.count') do
      post growth_observations_url, params: { growth_observation: { bbch_stage_id: @growth_observation.bbch_stage_id, observation_date: @growth_observation.observation_date, percent_at_stage: @growth_observation.percent_at_stage, plant_instance_id: @growth_observation.plant_instance_id } }
    end

    assert_redirected_to growth_observation_url(GrowthObservation.last)
  end

  test "should show growth_observation" do
    get growth_observation_url(@growth_observation)
    assert_response :success
  end

  test "should get edit" do
    get edit_growth_observation_url(@growth_observation)
    assert_response :success
  end

  test "should update growth_observation" do
    patch growth_observation_url(@growth_observation), params: { growth_observation: { bbch_stage_id: @growth_observation.bbch_stage_id, observation_date: @growth_observation.observation_date, percent_at_stage: @growth_observation.percent_at_stage, plant_instance_id: @growth_observation.plant_instance_id } }
    assert_redirected_to growth_observation_url(@growth_observation)
  end

  test "should destroy growth_observation" do
    assert_difference('GrowthObservation.count', -1) do
      delete growth_observation_url(@growth_observation)
    end

    assert_redirected_to growth_observations_url
  end
end
