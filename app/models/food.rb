class Food < ActiveRecord::Base
  has_many :orders,
    inverse_of: :food
  belongs_to :food_category,
    inverse_of: :foods
  validates_presence_of :name
  validates_presence_of :food_category

  def section
    food_category.section
  end

  def section_id
    food_category.section.id
  end
end
