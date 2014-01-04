class OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      redirect_to root_path, notice: 'Order placed successfully'
    else
      render :new
    end
  end

  protected
  def order_params
    params.require(:order).permit(:food_id, :user_id, :arrival_time)
  end

end
