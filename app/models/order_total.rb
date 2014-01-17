class OrderTotal

  def initialize(start_date='2014-1-1', end_date= DateTime.tomorrow)
    @start_date = start_date.to_date
    @end_date = end_date.to_date
  end

  def find_orders_in_range(current_page=1)
    Order.where("arrival_time >= ? AND arrival_time <= ?",
     @start_date, @end_date).order(:arrival_time)
    .paginate(per_page: 10, page: current_page)
  end

  class << self
    def todays_orders
      orders = OrderTotal.new(Date.today, DateTime.tomorrow)
    end
  end
end
