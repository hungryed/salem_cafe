class Food < ActiveRecord::Base
  has_many :orders,
    inverse_of: :food
  belongs_to :food_category,
    inverse_of: :foods
  validates_presence_of :name
  validates_presence_of :food_category
  validates_uniqueness_of :name, scope: :food_category
  mount_uploader :picture, FoodPhotoUploader
  validates_format_of :price,
    with: /\A\$?\d+(\.\d{1,2})?\z/
  validates_numericality_of :price, greater_than_or_equal_to: 0
  belongs_to :section,
    inverse_of: :foods
end
