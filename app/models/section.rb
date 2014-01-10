class Section < ActiveRecord::Base
  has_many :orders,
    inverse_of: :section
  has_many :food_categories,
    inverse_of: :section
  validates_presence_of :name

  def todays_orders
    orders.find_all do |order|
      order.arrival_time.today?
    end
  end

  def foods
    food_categories.map(&:foods).flatten
  end
end
