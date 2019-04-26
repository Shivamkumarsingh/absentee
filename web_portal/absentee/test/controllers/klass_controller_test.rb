require 'test_helper'

class KlassControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get klass_new_url
    assert_response :success
  end

  test "should get create" do
    get klass_create_url
    assert_response :success
  end

  test "should get edit" do
    get klass_edit_url
    assert_response :success
  end

  test "should get update" do
    get klass_update_url
    assert_response :success
  end

  test "should get index" do
    get klass_index_url
    assert_response :success
  end

end
