require 'test_helper'

class UserMealHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_meal_histories_show_url
    assert_response :success
  end

  test "should get add_meal" do
    get user_meal_histories_add_meal_url
    assert_response :success
  end

end
