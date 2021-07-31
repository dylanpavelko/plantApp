require 'test_helper'
require_relative '../helpers/authorization_helper'


class DivisionsControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @division = divisions(:one)
    test_user = { email: 'userone@test.com', password: 'password', admin: true }
    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)
  end

  test "should get index" do
    get divisions_url
    assert_response :success
  end

  test "should get new" do
    get new_division_url
    assert_response :success
  end

  test "should create division" do
    assert_difference('Division.count') do
      post divisions_url, params: { division: { description: @division.description, name: @division.name } }
    end

    assert_redirected_to division_url(Division.last)
  end

  test "should show division" do
    get division_url(@division)
    assert_response :success
  end

  test "should get edit" do
    get edit_division_url(@division)
    assert_response :success
  end

  test "should update division" do
    patch division_url(@division), params: { division: { description: @division.description, name: @division.name } }
    assert_redirected_to division_url(@division)
  end

  test "should destroy division" do
    assert_difference('Division.count', -1) do
      delete division_url(@division)
    end

    assert_redirected_to divisions_url
  end
end
