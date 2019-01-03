class MealCart < ApplicationRecord
	#User which created the meal
    belongs_to :user
    #Meals of the meal cart
	has_and_belongs_to_many :meals
end

