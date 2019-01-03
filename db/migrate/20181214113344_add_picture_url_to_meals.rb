class AddPictureUrlToMeals < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :picture_url, :string
  end
end
