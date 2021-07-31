require 'test_helper'
require_relative '../helpers/authorization_helper'

class KingdomsControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @kingdom = kingdoms(:one)
    test_user = { email: 'userone@test.com', password: 'password', admin: true }
    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)
  end

  test "should get index" do
    get kingdoms_url
    assert_response :success
  end

  test "should get new" do
    get new_kingdom_url
    assert_response :success
  end

  test "should create kingdom" do
    assert_difference('Kingdom.count') do
      post kingdoms_url, params: { kingdom: { description: @kingdom.description, name: @kingdom.name }}, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials('dhh', 'secret')} 
    end

    assert_redirected_to kingdom_url(Kingdom.last)
  end

  test "should show kingdom" do
    get kingdom_url(@kingdom)
    assert_response :success
  end

  test "should get edit" do
    get edit_kingdom_url(@kingdom)
    assert_response :success
  end

  test "should update kingdom" do
    patch kingdom_url(@kingdom), params: { kingdom: { description: @kingdom.description, name: @kingdom.name } }
    assert_redirected_to kingdom_url(@kingdom)
  end

  test "should destroy kingdom" do
    assert_difference('Kingdom.count', -1) do
      delete kingdom_url(@kingdom)
    end

    assert_redirected_to kingdoms_url
  end

end
