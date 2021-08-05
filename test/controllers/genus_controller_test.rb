require 'test_helper'
require_relative '../helpers/authorization_helper'

class GenusControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @genu = genus(:one)
    test_user = { email: 'userone@test.com', password: 'password', admin: true }
    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)
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
      post genus_url, params: { genu: { description: @genu.description, name: @genu.name, family_id: new_family.id } }
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
