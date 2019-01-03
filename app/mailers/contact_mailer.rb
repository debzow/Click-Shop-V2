class ContactMailer < ApplicationMailer

	def welcome(user) 
		@user = user
        mail(to: @user.email, subject:'sujet bienvenue de test')
    end

    def shop_list(shop_list, user)
		@list_by_store = {}
	    shop_list.shopping_lists_details.each do |ingredient_detail|
			ingredient = Ingredient.find(ingredient_detail.ingredient_id) 
			name = ingredient.name 
			quantity = ingredient_detail.quantity 
			quantity_type = ingredient.quantity_type.name 
			stor_section = ingredient.store_section.name 

			if @list_by_store[stor_section] 
				@list_by_store[stor_section][name] = [quantity_type,quantity] 
			else 
				@list_by_store[stor_section] = {} 
				@list_by_store[stor_section][name] = [quantity_type,quantity]  
			end 
		end

    	@user = user
    	@shop_list = shop_list
        mail(to: @user.email, subject:'votre liste')

    end
end

