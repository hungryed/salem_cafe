class Food < ActiveRecord::Base
  has_many :orders,
    inverse_of: :food
  belongs_to :food_category,
    inverse_of: :foods
  belongs_to :section,
    inverse_of: :foods
  validates_presence_of :name
  validates_presence_of :food_category

end
