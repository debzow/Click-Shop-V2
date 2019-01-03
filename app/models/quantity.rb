class Quantity < ApplicationRecord
	# Associations :
	belongs_to :meal
	belongs_to :ingredient

	# Validations :
	validates :quantity, presence: true
end
