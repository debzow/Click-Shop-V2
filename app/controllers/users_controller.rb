class UsersController < ApplicationController

	def show
		#profil
		@user = current_user
		#meals parameters
		@user_food_restrictions = current_user.food_restrictions
		@user_ustensils = current_user.ustensils
		@user_household = current_user.household 
		#created meals
		@user_created_meals = current_user.created_meals
		#favorit meals
		@user_favorit_meals = current_user.favorit_meals
	end

	def edit_meal_parameter
		#generation of variable to display ustensils checkbox (already checked if user possess the ustensil)
		ustensils = Ustensil.all
		user_ustensils = current_user.ustensils
		@user_ustensils_checkbox = Hash.new
		ustensils.each do |ustensil|
			if user_ustensils.include?(ustensil)
				@user_ustensils_checkbox[ustensil.name]=true
			else
				@user_ustensils_checkbox[ustensil.name]=false
			end
		end
		#generation of variable to display ingredient_type checkbox (already checked if user has a food retriction on it)
		ingredient_types = IngredientType.all
		food_restrictions = current_user.food_restrictions
		@food_restrictions_checkbox = Hash.new
		ingredient_types.each do |ingredient_type|
			if food_restrictions.include?(ingredient_type)
				@food_restrictions_checkbox[ingredient_type.name]=true
			else
				@food_restrictions_checkbox[ingredient_type.name]=false
			end
		end
		#generation of variable to diplay household number dropdown
		if current_user.household
			@household = current_user.household
		else
			@household = 1
		end
		i=1
		@household_max_number = []
		19.times do
			@household_max_number << [i, i]
			i+=1
		end
	end

	def update_meal_parameter
		#update user's ustensils
		user_ustensils = current_user.ustensils
		user_ustensils.delete_all
		ustensils = Ustensil.all
		ustensils.each do |ustensil|
			if true?(params[ustensil.name])
				user_ustensils << ustensil
			 end
		end
		#update user's food restrictions
		food_restrictions = current_user.food_restrictions
		food_restrictions.delete_all
		ingredient_types = IngredientType.all
		ingredient_types.each do |ingredient_type|
			if true?(params[ingredient_type.name])
				food_restrictions << ingredient_type
			end
		end
		#update user's household number
		new_household = params[:dropdown][:household_number]
		current_user.update(household: new_household)
		redirect_to users_show_path
	end

	def edit 

	end

	def create
		@user = User.create!
		@user.skip_confirmation!
	    redirect_to user_path(current_user.id)
	end

	def true?(obj)
		obj.to_s == "true"
	end
	
end
