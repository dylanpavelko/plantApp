require 'test_helper'
require_relative '../helpers/authorization_helper'

class FamiliesControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @family = families(:one)
    test_user = { email: 'userone@test.com', password: 'password', admin: true }
    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)
  end

  test "should get index" do
    get families_url
    assert_response :success
  end

  test "should get new" do
    get new_family_url
    assert_response :success
  end

  test "should create family" do
    assert_difference('Family.count') do
      post families_url, params: { family: { description: @family.description, name: @family.name, order_id: new_order.id } }
    end

    assert_redirected_to family_url(Family.last)
  end

  test "should show family" do
    get family_url(@family)
    assert_response :success
  end

  test "should get edit" do
    get edit_family_url(@family)
    assert_response :success
  end

  test "should update family" do
    patch family_url(@family), params: { family: { description: @family.description, name: @family.name } }
    assert_redirected_to family_url(@family)
  end

  test "should destroy family" do
    assert_difference('Family.count', -1) do
      delete family_url(@family)
    end

    assert_redirected_to families_url
  end
end
