class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.belongs_to :ingredient_type, index: true
      t.belongs_to :store_section, index: true
      t.belongs_to :quantity_type, index: true
      t.string :name
      t.timestamps
    end
  end
end
