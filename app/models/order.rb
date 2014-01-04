class Order < ActiveRecord::Base
  belongs_to :user,
    inverse_of: :orders
  belongs_to :food,
    inverse_of: :orders

  validates_presence_of :user
  validates_presence_of :food
  validates_presence_of :arrival_time

end
