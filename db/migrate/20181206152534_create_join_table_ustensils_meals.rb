class CreateJoinTableUstensilsMeals < ActiveRecord::Migration[5.2]
  def change
    create_join_table :ustensils, :meals do |t|
    	t.belongs_to :ustensil, index: true
    	t.belongs_to :meal, index: true
      # t.index [:ustensil_id, :meal_id]
      # t.index [:meal_id, :ustensil_id]
    end
  end
end
