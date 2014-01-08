class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
  end

  def show

  end

  def create
    @order = current_user.orders.build(order_params)
    @order.section = (Food.find(params[:order][:food_id])).section

    if @order.save
      redirect_to root_path, notice: 'Order placed successfully'
    else
      render :new
    end
  end

  def destroy
    @order = current_user.todays_order

    if @order.destroy
      redirect_to root_path, notice: 'Order cancelled'
    end
  end

  def edit
    @order = current_user.todays_order
  end

  def update
    @order = current_user.todays_order

    if @order.update(order_params)
      redirect_to root_path, notice: 'Order changed successfully'
    else
      render :new
    end
  end

  protected
  def order_params
    params.require(:order).permit(:food_id, :user_id, :arrival_time)
  end

end
