class Ustensil < ApplicationRecord

	#Associations :
	#users wich have this ustensil in ther kitchen 
	has_and_belongs_to_many :users	
	#meals wich require this ustensil to be prepared  
	has_and_belongs_to_many :meals

	# Validations
	validates :name, presence: true, uniqueness: {case_sensitive: false}
end
