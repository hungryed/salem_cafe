class Food < ActiveRecord::Base
  has_many :orders,
    inverse_of: :food
  validates_presence_of :name

end
