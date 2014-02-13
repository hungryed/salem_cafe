class Order < ActiveRecord::Base
  belongs_to :user,
    inverse_of: :orders
  has_many :order_foods
  has_many :foods,
    through: :order_foods
  belongs_to :section,
    inverse_of: :orders
  validates_presence_of :user
  validates_presence_of :arrival_time
  validates_datetime :arrival_time,
    between: ['7:00am', '2:00pm']
  validates_futureness_of :arrival_time
  validates_presence_of :section
  validates_inclusion_of :status, in: ['in progress', 'completed', 'not started']
  def completed?
    status == 'completed'
  end

  def clean_arrival_time
    arrival_time.to_datetime.strftime('%m-%d %I:%M%p')
  end

  def display_string
    foods_names = foods.map(&:name)
    foods_names.join(" with ")
  end
end
