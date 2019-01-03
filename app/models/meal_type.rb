class MealType < ApplicationRecord
	# Associations :
	has_many :meals

	# Validations :
	validates :name, presence: true, uniqueness: {case_sensitive: false}
end
