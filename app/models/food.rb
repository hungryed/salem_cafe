class Food < ActiveRecord::Base
  has_many :orders,
    inverse_of: :food
  belongs_to :food_category,
    inverse_of: :foods
  validates_presence_of :name
  validates_presence_of :food_category
  mount_uploader :picture, FoodPhotoUploader

  def section
    food_category.section
  end

  def section_id
    food_category.section.id
  end

  def self.picture_list
    @food_pictures = Food.all.map do |food|
      food if food.picture_url.present?
    end
    @food_pictures.delete(nil)
    @food_pictures
  end
end
