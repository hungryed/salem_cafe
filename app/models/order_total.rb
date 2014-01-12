class OrderTotal

  def initialize(start_date='2014-1-1', end_date= DateTime.tomorrow)
    @start_date = start_date.to_date
    @end_date = end_date.to_date
  end

  def find_orders_in_range
    Order.all.find_all do |order|
      order.arrival_time.between?(@start_date, @end_date)
    end
  end

  class << self
    def todays_orders
      orders = OrderTotal.new(Date.today, DateTime.tomorrow)
      orders.find_orders_in_range
    end
  end
end
