require 'test_helper'

class PlantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @plant = plants(:one)
  end

  test "should get index" do
    get plants_url
    assert_response :success
  end

  test "should get new" do
    get new_plant_url
    assert_response :success
  end

  test "should create plant" do
    assert_difference('Plant.count') do
      post plants_url, params: { plant: { division_id: @plant.division_id, family_id: @plant.family_id, genus_id: @plant.genus_id, kingdom_id: @plant.kingdom_id, order_id: @plant.order_id, plant_class_id: @plant.plant_class_id, species_id: @plant.species_id, variety_id: @plant.variety_id } }
    end

    assert_redirected_to plant_url(Plant.last)
  end

  test "should show plant" do
    get plant_url(@plant)
    assert_response :success
  end

  test "should get edit" do
    get edit_plant_url(@plant)
    assert_response :success
  end

  test "should update plant" do
    patch plant_url(@plant), params: { plant: { division_id: @plant.division_id, family_id: @plant.family_id, genus_id: @plant.genus_id, kingdom_id: @plant.kingdom_id, order_id: @plant.order_id, plant_class_id: @plant.plant_class_id, species_id: @plant.species_id, variety_id: @plant.variety_id } }
    assert_redirected_to plant_url(@plant)
  end

  test "should destroy plant" do
    assert_difference('Plant.count', -1) do
      delete plant_url(@plant)
    end

    assert_redirected_to plants_url
  end
end
