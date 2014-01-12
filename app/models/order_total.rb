class OrderTotal

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def find_orders_in_range
    Order.find_each do |order|
      order.arrival_time.between?(@start_date, @end_date)
    end
  end

  class << self
    def todays_orders
      Order.find_each do |order|
        order.arrival_time.today?
      end
    end
  end
end
