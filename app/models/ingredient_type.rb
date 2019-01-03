class IngredientType < ApplicationRecord
	# Associations
	has_many :ingredients
	#users witch have an ingredient type restriction
  	has_many :ingredient_type_restriction
  	has_many :restricted_users, through: :ingredient_type_restriction, :source => :user

	# Validations
	validates :name, presence: true, uniqueness: {case_sensitive: false}
end
