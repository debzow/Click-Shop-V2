class MealsController < ApplicationController
  
  def index
    @meals = Meal.all
    @meal_types = meal_types
    @ingredient_types = ingredients_type

  end

  def search_by_name
    @meal_types = meal_types
    @ingredient_types = ingredients_type
    if @meals = Meal.where("name ILIKE ?", "%#{params[:search]}%").order("name")
      render :index
    else
      @meals = Meal.all
    end
  end

  def search_by_categories
    @ingredient_types = ingredients_type
    @meal_types = meal_types
     
    ingredient_type_id =  params[:search_categories][:ingredient_type_id]
    @meals_by_ingredient_types = []
    if (ingredient_type_id != "")
      ingredients = Ingredient.where(ingredient_type_id: ingredient_type_id)
      ingredients.each do |ingredient|
        ingredient.meals.each do |meal|
          @meals_by_ingredient_types << meal
        end
      end
    else
      @meals_by_ingredient_types = Meal.all
    end
    
    meals_types_id = params[:search_categories][:meal_type_id]
    @meals_by_meal_types = []
    if (meals_types_id != "")
      type_meals = Meal.where(meal_type_id: meals_types_id)
      type_meals.each do |type|
          @meals_by_meal_types << type
      end
    else
      @meals_by_meal_types = Meal.all
    end 

    @meals = []
    @meals_by_ingredient_types.each do |meal_by_ingredient_types|
      if @meals_by_meal_types.include?(meal_by_ingredient_types)
        @meals << meal_by_ingredient_types
      end
    end

    render :index
  end

  def show
    meals = Meal.all
    #limiting to 3 first meals
    @meals = []
    i=0
    3.times do
      if meals[i]
        @meals << meals[i]
      end
        i+=1
    end
  	 @meal = Meal.find(params[:id])
  end

  def new
    
    @new_meal = Meal.new
    @ingredient_quantity_type_list = [["CHOISIZEZ UN INGREDIENT", 0]]
    @ingredients = Ingredient.all
    @ingredients.each do |ingredient| 
      ingredient_quantity_type = ingredient.name + " (" + ingredient.quantity_type.name + ")"
      @ingredient_quantity_type_list << [ingredient_quantity_type, ingredient.id]
    end

    #generation of variable to display ustensils checkbox
		ustensils = Ustensil.all
    @ustensils_checkbox = Hash.new
		ustensils.each do |ustensil|
		  @ustensils_checkbox[ustensil.name]=false
    end
  
      respond_to do |format|
        format.js
        format.html
      end
  end

  def create
    
    meal_params = params['meal']
    ingredient_params = params["ingrdients"]

    meal = Meal.create(name: meal_params['name'], description: meal_params['description'], receipe: meal_params['receipe'], user_id: current_user.id, meal_type_id: meal_params['meal_type_id'])

    #update meal's ingredient
    i=1
    5.times do
      ingredient_id = ingredient_params["ingredient_#{i}"].to_i
      quantity = params["quantity_#{i}"].to_f
       unless ingredient_id.to_i == 0 || quantity == nil
        Quantity.create(meal_id: meal.id, ingredient_id: ingredient_id.to_i, quantity: quantity )
         i+=1
       end
    end

    #update meal's ustensils
		ustensils = Ustensil.all
		ustensils.each do |ustensil|
			if true?(params[ustensil.name])
				meal.ustensils << ustensil
			 end
		end

	redirect_to meal_path(meal.id)
  end
    
  def favmeal
    @mealpro = Meal.find(params[:id])
    @mealpro.favorit_users << current_user
     redirect_to meals_path
   end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.favorit_users.delete(current_user)
    redirect_to meals_path
  end



private

  def meal_params
    result = params.require(:meal).permit(:name, :description, :receipe, :user_id, :meal_type_id)
    # result[:user_id] = current_user.id
    # return result
  end

  def ingredients_type
     ingredient_types = []
    IngredientType.order(:name).each do |ingredient_type|
      ingredient_types << [ingredient_type.name, ingredient_type.id]
    end
    return ingredient_types
  end

  def meal_types
    type_of_meals = []
    MealType.order(:name).each do |meal_type|
      type_of_meals << [meal_type.name, meal_type.id]
    end
    return type_of_meals
  end

  def true?(obj)
		obj.to_s == "true"
  end
end
