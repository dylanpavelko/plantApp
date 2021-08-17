require 'test_helper'
require_relative '../helpers/authorization_helper'

class BbchProfilesControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @bbch_profile = bbch_profiles(:one)
    test_user = { email: 'userone@test.com', password: 'password', admin: true }
    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)
  end

  test "should get index" do
    get bbch_profiles_url
    assert_response :success
  end

  test "should get new" do
    get new_bbch_profile_url
    assert_response :success
  end

  test "should create bbch_profile" do
    assert_difference('BbchProfile.count') do
      post bbch_profiles_url, params: { bbch_profile: { name: @bbch_profile.name } }
    end

    assert_redirected_to bbch_profile_url(BbchProfile.last)
  end

  test "should show bbch_profile" do
    get bbch_profile_url(@bbch_profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_bbch_profile_url(@bbch_profile)
    assert_response :success
  end

  test "should update bbch_profile" do
    patch bbch_profile_url(@bbch_profile), params: { bbch_profile: { name: @bbch_profile.name } }
    assert_redirected_to bbch_profile_url(@bbch_profile)
  end

  test "should destroy bbch_profile" do
    assert_difference('BbchProfile.count', -1) do
      delete bbch_profile_url(@bbch_profile)
    end

    assert_redirected_to bbch_profiles_url
  end
end
