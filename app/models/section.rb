class Section < ActiveRecord::Base
  has_many :orders,
    inverse_of: :section
  has_many :food_categories,
    inverse_of: :section
  validates_presence_of :name
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_time :start_time,
    before: :end_time
  validates_time :start_time,
    between: ['7:00am', '2:00pm']
  validates_time :end_time,
    between: ['7:00am', '2:00pm']

  def todays_orders
    orders.find_all do |order|
      order.arrival_time.today? && order.status != 'completed'
    end
  end

  def foods
    food_categories.map(&:foods).flatten
  end
end
