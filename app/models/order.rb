class Order < ActiveRecord::Base
  belongs_to :user,
    inverse_of: :orders
  belongs_to :food,
    inverse_of: :orders
  belongs_to :section,
    inverse_of: :orders

  validates_presence_of :user
  validates_presence_of :food
  validates_presence_of :arrival_time
  validates_datetime :arrival_time,
    between: ['7:00am', '2:00pm']
  validates_futureness_of :arrival_time
  validates_presence_of :section
end
