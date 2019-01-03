class CreateJoinTableUstensilsUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :ustensils, :users do |t|
    	t.belongs_to :user, index: true
    	t.belongs_to :ustensil, index: true
      # t.index [:ustensil_id, :user_id]
      # t.index [:user_id, :ustensil_id]
    end
  end
end
