class ShoppingList < ApplicationRecord
  # Shopping list have been created by one user
  belongs_to :user
  # Shopping list details (all ingredients and there quantity)
  has_many :shopping_lists_details
  # Shopping list countain many ingredients
  has_many :ingredients, through: :shopping_lists_details
end
