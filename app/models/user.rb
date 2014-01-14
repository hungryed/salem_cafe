class User < ActiveRecord::Base
  has_many :orders,
    inverse_of: :user
  validates_presence_of :first_name
  validates_presence_of :last_name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def todays_uncompleted_orders
    orders.map do |order|
      order if order.arrival_time.today? && order.status != 'complete'
    end
  end

  def is_employee?
    role == 'worker' || role == 'admin'
  end

  def is_admin?
    role == 'admin'
  end
end
