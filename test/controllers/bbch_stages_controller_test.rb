require 'test_helper'
require_relative '../helpers/authorization_helper'

class BbchStagesControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @bbch_stage = bbch_stages(:one)
    test_user = { email: 'userone@test.com', password: 'password', admin: true }
    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)
  end

  test "should get index" do
    get bbch_stages_url
    assert_response :success
  end

  test "should get new" do
    get new_bbch_stage_url
    assert_response :success
  end

  test "should create bbch_stage" do
    assert_difference('BbchStage.count') do
      post bbch_stages_url, params: { bbch_stage: { bbch_profile_id: @bbch_stage.bbch_profile_id, code: @bbch_stage.code, description: @bbch_stage.description, note: @bbch_stage.note } }
    end

    assert_redirected_to bbch_profile_url(@bbch_stage.bbch_profile)
  end

  test "should show bbch_stage" do
    get bbch_stage_url(@bbch_stage)
    assert_response :success
  end

  test "should get edit" do
    get edit_bbch_stage_url(@bbch_stage)
    assert_response :success
  end

  test "should update bbch_stage" do
    patch bbch_stage_url(@bbch_stage), params: { bbch_stage: { bbch_profile_id: @bbch_stage.bbch_profile_id, code: @bbch_stage.code, description: @bbch_stage.description, note: @bbch_stage.note } }
    assert_redirected_to bbch_stage_url(@bbch_stage)
  end

  test "should destroy bbch_stage" do
    assert_difference('BbchStage.count', -1) do
      delete bbch_stage_url(@bbch_stage)
    end

    assert_redirected_to bbch_stages_url
  end
end
