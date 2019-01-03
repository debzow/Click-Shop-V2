Rails.application.routes.draw do

 
  devise_for :users
  root 'statics#index'
  get 'contact', to: 'statics#contact'
  resources :meals

  get 'meals/favmeal/:id', to: 'meals#favmeal', as: 'meal_favmeal'
  get 'users/show', to:'users#show'
  get 'users/edit_meal_parameter', to:'users#edit_meal_parameter'
  get 'users/update_meal_parameter', to:'users#update_meal_parameter'

  match '/search_by_name', to: 'meals#search_by_name', via: 'get'
  match '/search_by_categories', to: 'meals#search_by_categories', via: 'get'

  #routes to MealCarts
  get 'meal_carts/show', to:'meal_carts#show', as: 'meal_carts_show'
  get 'meal_carts/new', to:'meal_carts#new'
  get 'meal_carts/generate', to:'meal_carts#generate'
  get 'meal_carts/choice', to:'meal_carts#choice'
  delete 'meal_carts/reinitiate', to:'meal_carts#reinitiate'
  put 'meal_carts/add_meal/:id', to: 'meal_carts#add_meal', as: 'add_meal'
  delete 'meal_carts/delete_meal/:id', to: 'meal_carts#delete_meal', as: 'delete_meal'

  #routes to ShoppingLists
  get 'shopping_lists/generate', to:'shopping_lists#generate'
  get 'shopping_lists/show', to: 'shopping_lists#show'
  delete 'shopping_lists/delete_ingredient/:id', to: 'shopping_lists#delete_ingredient', as: 'delete_ingredient'
  get 'shopping_lists/add_ingredient/show', to: 'shopping_lists#add_ingredient_show'
  post 'shopping_lists/add_ingredient', to: 'shopping_lists#add_ingredient'
  get 'shopping_lists/add_quantity_per_ingredient/show/:id', to: 'shopping_lists#add_quantity_per_ingredient_show', as: 'shopping_lists_add_quantity_per_ingredient_show'
  post 'shopping_lists/add_quantity_per_ingredient', to: 'shopping_lists#add_quantity_per_ingredient'
  get 'shopping_lists/share', to:'shopping_lists#share'

  #routes user meal historic
  get 'user_meal_historic', to: 'user_meal_histories#show'

  #routes to DatabaseMealsManager (only admin)
  get 'manager/get_meal', to: 'database_meals_manager#get_meal'
  post 'manager/create_meal', to: 'database_meals_manager#create_meal'
  get 'manager/err_meal', to: 'database_meals_manager#err_meal'
  get 'manager/select_meal', to: 'database_meals_manager#select_meal'
  get 'manager/edit_meal_ustensils', to: 'database_meals_manager#edit_meal_ustensils'
  post 'manager/update_meal_ustensils', to: 'database_meals_manager#update_meal_ustensils'
  get 'manager/select_ingredient', to: 'database_meals_manager#select_ingredient'
  get 'manager/edit_ingredient_store_section', to: 'database_meals_manager#edit_ingredient_store_section'
  post 'manager/update_ingredient_store_section', to: 'database_meals_manager#update_ingredient_store_section'
  get 'manager/edit_ingredient_type', to: 'database_meals_manager#edit_ingredient_type'
  post 'manager/update_ingredient_type', to: 'database_meals_manager#update_ingredient_type'
  
end
