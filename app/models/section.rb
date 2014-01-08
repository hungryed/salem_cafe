class Section < ActiveRecord::Base
  has_many :orders,
    inverse_of: :section
  has_many :foods,
    inverse_of: :section
  validates_presence_of :name
end
