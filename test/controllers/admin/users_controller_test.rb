require "test_helper"

class Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_users_edit_url
    assert_response :success
  end
end
