class FoodCategory < ActiveRecord::Base
  belongs_to :section,
    inverse_of: :food_categories
  has_many :foods,
    inverse_of: :category
  validates_presence_of :name
  validates_presence_of :section
end
