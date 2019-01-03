class Meal < ApplicationRecord
	# Associations :
	#the user witch created the meal
	belongs_to :creator, :class_name => "User", foreign_key: 'user_id'
	#meal_type of the meal
	belongs_to :meal_type
	#quantity of each ingredients included in the meal
	has_many :quantities
	#ingredients included in the meal
	has_many :ingredients, through: :quantities
	#=== Example:
	# meal = Meal.first
	# meal.ingredients.each do |ingredient|
	# 	ingredient_quantity = Quantity.find_by(meal_id: meal.id,ingredient_id: ingredient.id).quantity
	# end
	#===
	#needed ustensils to cook the meal
	has_and_belongs_to_many :ustensils
	# (not useful)
	has_many :user_meal_favorits
	#users witch have this meal as favorit
	has_many :favorit_users, through: :user_meal_favorits, :source => :user
	# (not useful)
	has_many :user_meal_histories
	#user witch have this meal in ther history
	has_many :history_users, through: :user_meal_histories, :source => :user
	#Meal_carts which include the meal
	has_and_belongs_to_many :meal_carts

	# Validations :
	validates :name, presence: true
	validates :description, presence: true
	validates :receipe, presence: true

end

