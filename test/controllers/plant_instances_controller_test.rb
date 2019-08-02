require 'test_helper'

class PlantInstancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @plant_instance = plant_instances(:one)
  end

  test "should get index" do
    get plant_instances_url
    assert_response :success
  end

  test "should get new" do
    get new_plant_instance_url
    assert_response :success
  end

  test "should create plant_instance" do
    assert_difference('PlantInstance.count') do
      post plant_instances_url, params: { plant_instance: { location_id: @plant_instance.location_id, plant_id: @plant_instance.plant_id } }
    end

    assert_redirected_to plant_instance_url(PlantInstance.last)
  end

  test "should show plant_instance" do
    get plant_instance_url(@plant_instance)
    assert_response :success
  end

  test "should get edit" do
    get edit_plant_instance_url(@plant_instance)
    assert_response :success
  end

  test "should update plant_instance" do
    patch plant_instance_url(@plant_instance), params: { plant_instance: { location_id: @plant_instance.location_id, plant_id: @plant_instance.plant_id } }
    assert_redirected_to plant_instance_url(@plant_instance)
  end

  test "should destroy plant_instance" do
    assert_difference('PlantInstance.count', -1) do
      delete plant_instance_url(@plant_instance)
    end

    assert_redirected_to plant_instances_url
  end
end
