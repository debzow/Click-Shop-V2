class StaticsController < ApplicationController
  def index

    meals = Meal.all
    #limiting to 3 first meals
    @meals = []
    i=0
    3.times do
      if meals[i]
        @meals << meals[i]
      end
        i+=1
    end
    
  end

  def contact
  end
  
end
