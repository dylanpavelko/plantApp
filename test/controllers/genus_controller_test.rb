require 'test_helper'

class GenusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @genu = genus(:one)
  end

  test "should get index" do
    get genus_url
    assert_response :success
  end

  test "should get new" do
    get new_genu_url
    assert_response :success
  end

  test "should create genu" do
    assert_difference('Genu.count') do
      post genus_url, params: { genu: { description: @genu.description, name: @genu.name } }
    end

    assert_redirected_to genu_url(Genu.last)
  end

  test "should show genu" do
    get genu_url(@genu)
    assert_response :success
  end

  test "should get edit" do
    get edit_genu_url(@genu)
    assert_response :success
  end

  test "should update genu" do
    patch genu_url(@genu), params: { genu: { description: @genu.description, name: @genu.name } }
    assert_redirected_to genu_url(@genu)
  end

  test "should destroy genu" do
    assert_difference('Genu.count', -1) do
      delete genu_url(@genu)
    end

    assert_redirected_to genus_url
  end
end
