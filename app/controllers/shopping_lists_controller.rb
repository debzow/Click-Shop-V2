class ShoppingListsController < ApplicationController

  def generate
  	current_user_meals = current_user.meal_cart.meals
  	shopping_list_user = current_user.shopping_list

		if shopping_list_user != nil # Verification if current_user shopping_list exist
			redirect_to shopping_lists_show_path
		else # Creation of current_user shopping_list
			ShoppingList.create(user_id: current_user.id)
			redirect_to shopping_lists_show_path
		end

		shopping_list = ShoppingList.find_by(user_id: current_user.id)
			current_user_meals.each do |meal|
				meal.ingredients.each do |ingredient|
					@ingredient_detail = Quantity.find_by(meal_id: meal.id, ingredient_id: ingredient.id)
					if (ShoppingListsDetail.find_by(shopping_list_id: shopping_list.id, ingredient_id: ingredient.id)) # ingredient already exist in ShoppingListsDetail
						puts "#"*40
						@detail = ShoppingListsDetail.find_by(shopping_list_id: shopping_list.id, ingredient_id: ingredient.id)
						@new_quantity = @detail.quantity + (@ingredient_detail.quantity * current_user.household)
						puts "hold quantity"
						puts @detail.quantity
						puts "new quantity"
						puts @new_quantity
						@detail.update(quantity: @new_quantity)
					else  # ingredient new in ShoppingListsDetail
						ShoppingListsDetail.create(shopping_list_id: shopping_list.id, ingredient_id: ingredient.id, quantity: (@ingredient_detail.quantity * current_user.household))
					end
				end
			end
  end

  def show
		@shopping_list = ShoppingList.find_by(user_id: current_user.id)
		@list_id = @shopping_list.id
		@user = current_user
		#creating a shopping_list order by store {store => {name => [quantity_type, quantity]}}
		@list_by_store = {}
		@shopping_list.shopping_lists_details.each do |ingredient_detail|
			#ingredient details
			ingredient = Ingredient.find(ingredient_detail.ingredient_id)
			name = ingredient.name
			quantity = ingredient_detail.quantity
			quantity_type = ingredient.quantity_type.name
			stor_section = ingredient.store_section.name

			if @list_by_store[stor_section]
				@list_by_store[stor_section][name] = [quantity_type,quantity]
			else
				@list_by_store[stor_section] = {}
				@list_by_store[stor_section][name] = [quantity_type,quantity]
			end
		end
  end

  def delete_ingredient
    shopping_list = ShoppingList.find_by(user_id: current_user.id)

    # Delete ingredient in shopping_list
    @ingredient = shopping_list.ingredients.find(params[:id])
    shopping_list.ingredients.delete(@ingredient)

    redirect_to shopping_lists_show_path
  end

  def add_ingredient_show
    # Show all ingredients in dropdown
  	@ingredients = Ingredient.all
  end

  def add_ingredient
  	shopping_list = current_user.shopping_list

  	ingredient_to_add = Ingredient.find(params[:ingredient][:ingredient_id])
    #shopping_list.ingredients << @ingredient_add

  	redirect_to shopping_lists_add_quantity_per_ingredient_show_path(ingredient_to_add.id)
  end

	def add_quantity_per_ingredient_show
		ingredient_to_add_id = params[:id]
		@ingredient_to_add = Ingredient.find(ingredient_to_add_id)
    shopping_list = ShoppingList.find_by(user_id: current_user.id)

    # Show quantity_type
    @quantity_type = @ingredient_to_add.quantity_type
  end

	def add_quantity_per_ingredient
		puts "#"*20
		puts params[:quantity]
    shopping_list = ShoppingList.find_by(user_id: current_user.id)

    # Update of the new_quantity
		@new_ingredient_quantity = params[:quantity]
		@ingredient_to_add = Ingredient.find(params[:ingredient_id])
		shopping_list = current_user.shopping_list

		if @new_ingredient_quantity
			shopping_lists_detail = ShoppingListsDetail.find_by(shopping_list_id: shopping_list.id, ingredient_id: @ingredient_to_add.id)
			if shopping_lists_detail
				shopping_lists_detail.update(quantity: @new_ingredient_quantity)
			else
				shopping_list.ingredients << @ingredient_to_add
				shopping_lists_detail = ShoppingListsDetail.find_by(shopping_list_id: shopping_list.id, ingredient_id: @ingredient_to_add.id)
				shopping_lists_detail.update(quantity: @new_ingredient_quantity)
			end
      redirect_to shopping_lists_show_path
    else
      redirect_to shopping_lists_show_path
    end
  end

	def share
		shopping_list = ShoppingList.find_by(user_id: current_user.id)
		#send shopping list by email
		ContactMailer.shop_list(shopping_list, current_user).deliver_now

    redirect_to shopping_lists_show_path
  end

end
