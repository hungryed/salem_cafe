class OrderTotalsController < ApplicationController
  def index
    if params[:todays_orders] == 'true'
      @orders = OrderTotal.todays_orders
    elsif params[:order_date_params]
      date_params = params[:order_date_params]
      start_date = "#{date_params['start_date(1i)']}-#{date_params['start_date(2i)']}-#{date_params['start_date(3i)']}"
      end_date = "#{date_params['end_date(1i)']}-#{date_params['end_date(2i)']}-#{date_params['end_date(3i)']}"
      @orders = OrderTotal.new(start_date, end_date)
    else
      @orders = Order.all
    end
  end
end
