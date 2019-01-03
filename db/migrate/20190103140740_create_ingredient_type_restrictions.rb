class CreateIngredientTypeRestrictions < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredient_type_restrictions do |t|
      t.references :user, foreign_key: true
      t.references :ingredient_type, foreign_key: true
      
      t.timestamps
    end
  end
end
