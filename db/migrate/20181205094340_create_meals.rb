class CreateMeals < ActiveRecord::Migration[5.2]
  def change
    create_table :meals do |t|
      t.belongs_to :user, index: true
      t.belongs_to :meal_type, index: true
      t.string :name
      t.text :description
      t.text :receipe
      t.timestamps
    end
  end
end
