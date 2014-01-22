class OrderTotal

  def initialize(start_date='2014-1-1', end_date= DateTime.tomorrow)
    @start_date = start_date.to_date
    @end_date = end_date.to_date
  end

  def find_orders_in_range(current_page=1)
    Order.where("arrival_time >= ? AND arrival_time <= ?",
     @start_date, @end_date).order(:arrival_time)
    .page(current_page).per(10)
  end

  def divide_by_section
    @section_orders = Order.where("arrival_time >= ? AND arrival_time <= ?",
     @start_date, @end_date).group("section").count
    @section_order_totals = {}
    @section_orders.each do |section, order_count|
      @section_order_totals[section.name] = order_count
    end
    @section_order_totals
  end

  class << self
    def todays_orders
      orders = OrderTotal.new(Date.today, DateTime.tomorrow)
    end
  end
end
