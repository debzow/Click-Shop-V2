class IngredientType < ApplicationRecord
	# Associations
	has_many :ingredients
	#users witch have an ingredient type restriction
  	has_many :meal_restrictions
  	has_many :restricted_users, through: :meal_restrictions, :source => :user

	# Validations
	validates :name, presence: true, uniqueness: {case_sensitive: false}
end
