class Section < ActiveRecord::Base
  has_many :orders,
    inverse_of: :section
  has_many :food_categories,
    inverse_of: :section
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_time :end_time,
    after: :start_time
  validates_time :start_time,
    between: ['7:00am', '2:00pm']
  validates_time :end_time,
    between: ['7:00am', '2:00pm']

  def self.todays_orders(section_id, current_page=1)
    completed = 'completed'
    Order.where("section_id = #{section_id} AND status != ? AND arrival_time >= ?",
        completed, Date.today.to_datetime).order(:arrival_time)
        .page(current_page).per(10)
  end

  def foods
    food_categories.map(&:foods).flatten
  end
end
