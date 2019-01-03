class CreateQuantities < ActiveRecord::Migration[5.2]
  def change
    create_table :quantities do |t|
      t.belongs_to :meal, index: true
      t.belongs_to :ingredient, index: true
      t.float :quantity
      t.timestamps
    end
  end
end
