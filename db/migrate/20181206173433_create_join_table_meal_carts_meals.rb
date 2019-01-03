class CreateJoinTableMealCartsMeals < ActiveRecord::Migration[5.2]
  def change
    create_join_table :meal_carts, :meals do |t|
      t.belongs_to :meal_cart, index: true
      t.belongs_to :meal, index: true
      # t.index [:meal_cart_id, :meal_id]
      # t.index [:meal_id, :meal_cart_id]
    end
  end
end
