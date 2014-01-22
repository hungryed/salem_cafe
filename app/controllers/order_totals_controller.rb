class OrderTotalsController < ApplicationController
  before_filter :authorize_user_is_admin

  def index
    if params[:start_date] && params[:end_date]
      @start_date = Chronic.parse(params[:start_date]).to_s
      end_date = Chronic.parse(params[:end_date]).to_s
      @end_date = (end_date.to_date + 12.hours).to_s
      orders = OrderTotal.new(@start_date, @end_date)
      @orders = orders.find_orders_in_range(params[:page])
      @section_orders = orders.divide_by_section
    else
      orders = OrderTotal.todays_orders
      @orders = orders.find_orders_in_range(params[:page])
      @section_orders = orders.divide_by_section
    end
  end
end
