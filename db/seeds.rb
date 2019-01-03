require 'faker'

# Reset database :

# # Destroy MealCart and ShoppingList
ShoppingList.destroy_all
MealCart.destroy_all
ShoppingListsDetail.destroy_all
# # Destroy recipies
Quantity.destroy_all
QuantityType.destroy_all
# # Destroy meal_favorits and meal_histories and MealRestriction
UserMealFavorit.destroy_all
UserMealHistory.destroy_all
MealRestriction.destroy_all
# # Destroy Meals
Meal.destroy_all
MealType.destroy_all
# # Destroy Ingredients
Ingredient.destroy_all
IngredientType.destroy_all
StoreSection.destroy_all
# # Destroy Ustensils
Ustensil.destroy_all
# # Destroy Users
User.destroy_all 


# Generating ustensils
ustensils_array = ['Plaques Electriques', 'Plaque Chauffante ', 'Mixeur', 'Friteuse', 'Cocotte-Minute']
ustensils_array.each do |element|
	Ustensil.create(name: element)
end

# Generating meal_types
meals_types_array = ['meal_lunch','meal_dinner']

meals_types_array.each do |element|
	meal_types = MealType.create(name: element)
end

# Generating store_sections
store_section_array = ['Viande','Poisson','Poulet','Fruits et Légumes','Boulangerie','Boisson','Surgelé','Produit laitier','Epicerie','Conserve', 'Biscuit', 'Autre']

store_section_array.each do |element|
	store_sections = StoreSection.create(name: element)
end

# Generating ingredient_types
ingredient_type_array = ['Viande','Riche en sel','Riche en sucre','Riche en graisse', 'Autre']

ingredient_type_array.each do |element|
	ingredient_types = IngredientType.create(name: element)
end

# Generating quantity_types
quantity_types_array = ['tranche','gramme','centilitre']

quantity_types_array.each do |element|
	quantity_types = QuantityType.create(name: element)
end

# Generating ingredient
ingredient = Ingredient.create(name: "jambon", ingredient_type_id: IngredientType.first.id, store_section_id: StoreSection.first.id, quantity_type_id: QuantityType.first.id)


# ====== Generating users with : ======
# - 1 meals (created by himself) 
# - 1 ustensil present in is kitchen
# - 1 favorit meals
# - 1 history meals
# - 1 ingredient type restrictions
# - Generating a meal cart with 1 meal

user = User.create(username: "test", first_name: "David", last_name: "Gerardo", email:"test@gmail.com",household: 1, password: 'topsecret', password_confirmation: 'topsecret')
# Adding 1 random ustensil added to user
user.ustensils << Ustensil.find(Ustensil.first.id)
# Generating 1 meal created by user
meal = Meal.create(name: "Jambon", description: "c'est bon le jambon", receipe: "couper les tranches", user_id: user.id, meal_type_id: MealType.first.id)
# Addong 1 needed ustensil to prepare the meal
meal.ustensils << Ustensil.find(Ustensil.first.id)
# Generating recipies with 1 ingredient
quantities = Quantity.create(meal_id: meal.id, ingredient_id: ingredient.id, quantity: 2 )


# Adding 1 meal to user's favorit meals
user.favorit_meals << Meal.find(Meal.first.id)
# Adding 1 meals to user's history meals
user.history_meals << Meal.find(Meal.first.id)
# Adding 1 ingredient type restrictions
user.food_restrictions << IngredientType.find(IngredientType.last.id)

