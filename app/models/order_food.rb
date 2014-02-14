class OrderFood < ActiveRecord::Base
  belongs_to :food
  belongs_to :order
  # validates_presence_of :order
  validates_presence_of :food
end
