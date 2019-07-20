require 'test_helper'

class PlantClassesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @plant_class = plant_classes(:one)
  end

  test "should get index" do
    get plant_classes_url
    assert_response :success
  end

  test "should get new" do
    get new_plant_class_url
    assert_response :success
  end

  test "should create plant_class" do
    assert_difference('PlantClass.count') do
      post plant_classes_url, params: { plant_class: { description: @plant_class.description, name: @plant_class.name } }
    end

    assert_redirected_to plant_class_url(PlantClass.last)
  end

  test "should show plant_class" do
    get plant_class_url(@plant_class)
    assert_response :success
  end

  test "should get edit" do
    get edit_plant_class_url(@plant_class)
    assert_response :success
  end

  test "should update plant_class" do
    patch plant_class_url(@plant_class), params: { plant_class: { description: @plant_class.description, name: @plant_class.name } }
    assert_redirected_to plant_class_url(@plant_class)
  end

  test "should destroy plant_class" do
    assert_difference('PlantClass.count', -1) do
      delete plant_class_url(@plant_class)
    end

    assert_redirected_to plant_classes_url
  end
end
