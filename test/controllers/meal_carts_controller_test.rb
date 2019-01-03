require 'test_helper'

class MealCartsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get meal_carts_new_url
    assert_response :success
  end

  test "should get create" do
    get meal_carts_create_url
    assert_response :success
  end

  test "should get show" do
    get meal_carts_show_url
    assert_response :success
  end

end
