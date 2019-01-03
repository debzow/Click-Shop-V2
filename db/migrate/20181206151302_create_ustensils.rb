class CreateUstensils < ActiveRecord::Migration[5.2]
  def change
    create_table :ustensils do |t|
      t.string :name
      t.timestamps
    end
  end
end
