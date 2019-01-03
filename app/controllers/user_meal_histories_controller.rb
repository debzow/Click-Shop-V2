class UserMealHistoriesController < ApplicationController
  def show
  	@user_meal_histories = current_user.history_meals
  end
end
