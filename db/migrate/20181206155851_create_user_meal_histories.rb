class CreateUserMealHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :user_meal_histories do |t|
      t.belongs_to :user, index: true
      t.belongs_to :meal, index: true
      t.timestamps
    end
  end
end
