require 'test_helper'
require_relative '../helpers/authorization_helper'

class SpeciesControllerTest < ActionDispatch::IntegrationTest
  include AuthorizationHelper

  setup do
    @species = species(:one)
    test_user = { email: 'userone@test.com', password: 'password', admin: true }
    sign_up(test_user)
    @auth_tokens = auth_tokens_for_user(test_user)
  end

  test "should get index" do
    get species_index_url
    assert_response :success
  end

  test "should get new" do
    get new_species_url
    assert_response :success
  end

  test "should create species" do
    assert_difference('Species.count') do
      post species_index_url, params: { species: { description: @species.description, name: @species.name, genus_id: new_genus.id } }
    end

    assert_redirected_to species_url(Species.last)
  end

  test "should show species" do
    get species_url(@species)
    assert_response :success
  end

  test "should get edit" do
    get edit_species_url(@species)
    assert_response :success
  end

  test "should update species" do
    patch species_url(@species), params: { species: { description: @species.description, name: @species.name } }
    assert_redirected_to species_url(@species)
  end

  test "should destroy species" do
    assert_difference('Species.count', -1) do
      delete species_url(@species)
    end

    assert_redirected_to species_index_url
  end
end
