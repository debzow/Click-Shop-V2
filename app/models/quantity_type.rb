class QuantityType < ApplicationRecord
	# Associations :
	has_many :ingredients

	# Validations :
	validates :name, presence: true, uniqueness: {case_sensitive: false}
end
