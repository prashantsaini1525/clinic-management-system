require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get receptionist" do
    get dashboard_receptionist_url
    assert_response :success
  end

  test "should get doctor" do
    get dashboard_doctor_url
    assert_response :success
  end
end
