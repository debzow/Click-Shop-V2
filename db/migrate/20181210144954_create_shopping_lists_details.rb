class CreateShoppingListsDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_lists_details do |t|
      t.belongs_to :shopping_list, index: true
      t.belongs_to :ingredient, index: true
      t.float :quantity

      t.timestamps
    end
  end
end
