class Ingredient < ApplicationRecord
	# Associations :
	#ingredient_type of the ingredient (meat, vegetable, etc)
	belongs_to :ingredient_type
	#section of the ingredient in a store (dairy product, freez product, etc..)
	belongs_to :store_section
	#ingredient quantity_type (gramme, liter, etc)
	belongs_to :quantity_type
	#differents quantities (for one person) of the ingredient in each meals 
	has_many :quantities
	#meals wich include this ingredient
	has_many :meals, through: :quantities
	#differents quantities of the ingredient in a shopping_list 
	has_many :shopping_lists_details
	# shopping_lists wich include this ingredient
	has_many :shopping_lists, through: :shopping_lists_details

	# Validations :
	validates :name, presence: true, uniqueness: {case_sensitive: false}
end
