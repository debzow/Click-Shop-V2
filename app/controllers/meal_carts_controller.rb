class MealCartsController < ApplicationController

  def new
    #Delete shopping list
    shopping_list = ShoppingList.find_by(user_id: current_user.id)
    if shopping_list
      shopping_list.delete
    end

    meal_cart = current_user.meal_cart
    if meal_cart.meals.count > 0
      redirect_to meal_carts_choice_path
    else
      max_size = Meal.count
      @cart_max_size = []
      i = 1
      max_size.times do
        @cart_max_size << [i, i]
        i+=1
      end
    end
  end

  def add_meal
    @meal = Meal.find(params[:id])
    current_user_meals = current_user.meal_cart.meals
    current_user_meals << @meal
    redirect_to meals_path
  end

  def delete_meal
    @meal = current_user.meal_cart.meals.find(params[:id])
    current_user.meal_cart.meals.delete(@meal)
    redirect_to meal_carts_show_path
  end

  def choice
  end

  def reinitiate
    @add_to_history_meal = current_user.history_meals
    @meals = current_user.meal_cart.meals
    if @meals
      #add cart meals to user history_meals table before being deleted
      @meals.each do |meal|
        @add_to_history_meal << meal
      end
      #Delete all the meals of the meal_cart
      @meals.delete_all
    end
    redirect_to meal_carts_new_path
  end

  def generate
    meal_number = params[:user_choice][:meal_number].to_i
    meal_cart = current_user.meal_cart

    Meal.all.each do |meal|
      flag_1 = true
      meal.ustensils.each do |ustensil|
        unless current_user.ustensils.include?(ustensil)
          flag_1 = false
        end
      end
      if flag_1 #select meal if user has the need ustensils to prepare it
        meal_ingredient_type = []
        meal.ingredients.each do |ingredient|
          meal_ingredient_type << ingredient.ingredient_type
        end
        flag_2 = true
        current_user.food_restrictions.each do |element|
          if meal_ingredient_type.include?(element)
            flag_2 = false
          end
        end
        if flag_2 #select meal if the meal respect the user's food restrictions
          if meal_cart.meals.count < meal_number
              #add the meal to the meal_cart
              meal_cart.meals << meal
          end
        end

      end
    end

	  redirect_to meal_carts_show_path
  end

  def show
    @meal_cart = current_user.meal_cart
  end

end
