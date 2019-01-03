class User < ApplicationRecord
  #Activestorage associations:
  has_one_attached :image
  validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }
  # validates :photos, presence: true, blob: { content_type: %r{^image/}, size_range: 1..5.megabytes }

  #App Associations :
  #meals created by the user
  has_many :created_meals, :class_name => "Meal"
  #user's meal_cart (only one meal_cart per user)
  has_one :meal_cart
  #user's shopping_list (only one shopping_list per user)
  has_one :shopping_list
  #ustensils present in the user's kitchen
  has_and_belongs_to_many :ustensils
  # (not useful)
  has_many :user_meal_favorits
  #user's favorite_meals
  has_many :favorit_meals, through: :user_meal_favorits, :source => :meal
  # (not useful)
  has_many :user_meal_histories
  #all the meals already bouht by the user
  has_many :history_meals, through: :user_meal_histories, :source => :meal
  # (not useful)
  has_many :meal_restrictions
  #user's food_restrictions
  has_many :food_restrictions, through: :meal_restrictions, :source => :ingredient_type

  #Validations
	attr_accessor :login
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable, :trackable and :omniauthable
  validates :username, presence: true, uniqueness: {case_sensitive: false}, format: {with: /\A[a-zA-Z0-9 _\.]*\z/}
  validates :first_name, presence: true
  validates :last_name, presence: true

  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    def self.find_first_by_auth_conditions(warden_conditions)
    	conditions = warden_conditions.dup
    	if login = conditions.delete(:login)
    		where(conditions.to_hash).where("lower(username) = :value OR lower(email) = :value", value: login.downcase).first
    	else
    		where(conditions.to_hash).first
    	end
    end

  #create a meal_cart associate to the new user
  after_create do
    MealCart.create(user_id: self.id)
  end
end
