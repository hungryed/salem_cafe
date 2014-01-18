class User < ActiveRecord::Base
  has_many :orders,
    inverse_of: :user
  validates_presence_of :first_name
  validates_presence_of :last_name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def todays_uncompleted_orders(current_page=1)
    Order.where("user_id = #{self.id} AND status != ? AND status IS NOT NULL AND arrival_time >= ?",
     'completed', Date.today.to_datetime).order(arrival_time: :desc)
      .paginate(per_page: 10, page: current_page)
  end

  def all_orders(current_page=1)
    Order.where("user_id = #{self.id} AND status = ? AND status IS NOT NULL", 'completed')
    .order(arrival_time: :desc).paginate(per_page: 10, page: current_page)
  end

  def is_employee?
    role == 'worker' || role == 'admin'
  end

  def is_admin?
    role == 'admin'
  end

  def full_name
    [first_name, last_name].join(' ')
  end
end
