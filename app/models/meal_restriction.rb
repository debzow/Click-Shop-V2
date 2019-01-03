class MealRestriction < ApplicationRecord
  belongs_to :user
  belongs_to :ingredient_type
end
