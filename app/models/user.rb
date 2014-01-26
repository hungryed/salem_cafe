class User < ActiveRecord::Base
  has_many :orders,
    inverse_of: :user
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_inclusion_of :role, in: ['customer', 'worker', 'admin']
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def todays_uncompleted_orders(current_page=1)
    Order.where("user_id = #{self.id} AND status != ? AND status IS NOT NULL AND arrival_time >= ?",
     'completed', Date.today.to_datetime).order(arrival_time: :desc)
      .page(current_page).per(10)
  end

  def all_orders(current_page=1)
    Order.where("user_id = #{self.id} AND status = ? AND status IS NOT NULL", 'completed')
    .order(arrival_time: :desc).page(current_page).per(10)
  end

  def is_employee?
    role == 'worker' || role == 'admin'
  end

  def is_admin?
    role == 'admin'
  end

  def full_name
    [first_name, last_name].map(&:capitalize).join(' ')
  end
end
