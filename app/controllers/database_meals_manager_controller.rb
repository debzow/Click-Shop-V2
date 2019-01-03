require 'rest-client'
require 'json'

class DatabaseMealsManagerController < ApplicationController

  def get_meal
  end

  def create_meal
    search = params[:search]
    url = "https://www.wecook.fr/recipe/web-api/v2/recipes?uri="+search
    
    #if recipe do not exist in WeCook redirect to err view
    begin
      result = RestClient.get url, {content_type: "application/json;charset=utf-8", authorization: ENV['WECOOK_TOKEN']}
    rescue RestClient::ExceptionWithResponse => e
        #e.response
        redirect_to manager_err_meal_path
        return
    end

    body = result.body
    body_json = JSON.parse(body)
    meal_details = body_json["result"][0]

    unless Meal.find_by(name: meal_details["name"])
      #ingredient_type
      ingredient_type = IngredientType.find_by(name: "empty")
      unless ingredient_type
        ingredient_type = IngredientType.create(name: "empty")
      end
      #store_section
      store_section = StoreSection.find_by(name: "empty")
      unless store_section
        store_section = StoreSection.create(name: "empty")
      end
      #admin user  
      admin = User.find_by(username: "admin")
      #meal_type
      wc_meal_types = meal_details["tags"]["meals"]
      #if wc_meal_types contain multiple types choose 1 type randomly (in database only 1 meal_type can be associate to a meal)
      if wc_meal_types.kind_of?(Array)
        wc_meal_type = wc_meal_types[rand(0..(wc_meal_types.length-1))]
      else
        wc_meal_type = wc_meal_types
      end
      meal_type = MealType.find_by(name: wc_meal_type)
      unless meal_type
        meal_type = MealType.create(name: wc_meal_type)
      end
      #description
      description = "temps de preparation : " + meal_details["time"]["prep"].to_s + ", temps de cuisson : " + meal_details["time"]["bake"].to_s
      #receipe
      wc_receipe = meal_details["steps"]
      receipe = ""
      wc_receipe.each do |step|
          receipe = receipe + step["order"].to_s + " -- " +  step["step"] + " <br> "
      end
      #meal
      picture_url_flag = false
      begin
        result = RestClient.get meal_details["picture_url"]
        if result
          picture_url_flag = true
        end
      rescue RestClient::ExceptionWithResponse => e
      #e.response
      end
      meal = Meal.create(name: meal_details["name"], description: description, receipe: receipe, user_id: admin.id, meal_type_id: meal_type.id)
      if picture_url_flag
        meal.update(picture_url: meal_details["picture_url"])
      end
      #ingredient
      wc_ingredients = meal_details["ingredients"] 
      wc_ingredients.each do |wc_ingredient|
        ingredient = Ingredient.find_by(name: wc_ingredient["name"])
        unless ingredient
          #quantity_type
          quantity_type = QuantityType.find_by(name: wc_ingredient["unit"])
          unless quantity_type
            quantity_type = QuantityType.create(name: wc_ingredient["unit"])
          end
          #ingredient_type = nil & store_section = nil for a new ingredient
          ingredient = Ingredient.create(name: wc_ingredient["name"],ingredient_type_id: ingredient_type.id, store_section_id: store_section.id, quantity_type_id: quantity_type.id)
        end
        quantity = ((wc_ingredient["quantity"].to_f) / (meal_details["portions"].to_f)).round(2)
        Quantity.create(meal_id: meal.id, ingredient_id: ingredient.id, quantity: quantity)
      end
    else
      puts "Meal already exist in database!!!!!!"
    end

    redirect_to meal_path(meal.id)
  end

  def err_meal
  end

  def select_meal
    @meals_to_edit = []
    all_meals = Meal.all
    all_meals.each do |meal|
      if meal.ustensils.count == 0
        @meals_to_edit << [meal.name, meal.id]
      end
    end
  end

  def edit_meal_ustensils
    @meal = Meal.find(params[:meal][:meal_id].to_i)

		#generation of variable to display ustensils checkbox (already checked if user possess the ustensil)
		ustensils = Ustensil.all
		meal_ustensils = @meal.ustensils
		@meal_ustensils_checkbox = Hash.new
		ustensils.each do |ustensil|
			if meal_ustensils.include?(ustensil)
				@meal_ustensils_checkbox[ustensil.name]=true
			else
				@meal_ustensils_checkbox[ustensil.name]=false
			end
		end
  end

  def update_meal_ustensils
    #update meal's ustensils
    meal = Meal.find(params[:meal_id])
		meal_ustensils = meal.ustensils
		meal_ustensils.delete_all
		ustensils = Ustensil.all
		ustensils.each do |ustensil|
			if true?(params[ustensil.name])
				meal_ustensils << ustensil
			 end
    end
    redirect_to manager_select_meal_path
  end

  def select_ingredient
    @ingredients_edit_store = []
    all_ingredients = Ingredient.all
    all_ingredients.each do |ingredient|
      if ingredient.store_section.name == "empty"
        @ingredients_edit_store << [ingredient.name, ingredient.id]
      end
    end

    @ingredients_edit_type = []
    all_ingredients = Ingredient.all
    all_ingredients.each do |ingredient|
      if ingredient.ingredient_type.name == "empty"
        @ingredients_edit_type << [ingredient.name, ingredient.id]
      end
    end

  end

  def edit_ingredient_store_section
    @ingredient = Ingredient.find(params[:ingredient][:ingredient_id].to_i)

    #store_section dropdown
    @store_sections = []
    all_store_sections = StoreSection.all
    all_store_sections.each do |store_section|
      @store_sections << [store_section.name, store_section.id]
    end
  end

  def update_ingredient_store_section
    ingredient = Ingredient.find(params[:ingredient_id])
    ingredient.update(store_section_id: params[:store_section][:store_section_id])
    redirect_to manager_select_ingredient_path
  end

  def edit_ingredient_type
    @ingredient = Ingredient.find(params[:ingredient][:ingredient_id].to_i)

    #ingredient_type dropdown
    @ingredient_types = []
    all_ingredient_types = IngredientType.all
    all_ingredient_types.each do |ingredient_type|
      @ingredient_types << [ingredient_type.name, ingredient_type.id]
    end
  end

  def update_ingredient_type
    ingredient = Ingredient.find(params[:ingredient_id])
    ingredient.update(ingredient_type_id: params[:ingredient_type][:ingredient_type_id])
    redirect_to manager_select_ingredient_path
  end

  def true?(obj)
		obj.to_s == "true"
	end

end
