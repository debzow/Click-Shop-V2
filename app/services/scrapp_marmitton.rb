

class ScrappMarmitton
	attr_accessor :marmiton_url, :recipe

	def initialize
		@marmiton_url = 'https://www.750g.com/magret-de-canard-aux-endives-caramelisees-et-sauce-aux-groseilles-r204850.htm'
		@recipe = RecipeScraper::Recipe.new marmiton_url
	end

	def set_to_hash
		@recipe.to_hash
	end
end