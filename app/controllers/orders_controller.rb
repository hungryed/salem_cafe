class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user_is_not_employee, except: [:index, :show]

  def index
    if !current_user.nil?
      if current_user.is_employee?
        @orders = Section.find(params[:section_id]).todays_orders
        @current_section = Section.find(params[:section_id])
      else
        @orders = current_user.orders
      end
    end
  end

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = current_user.orders.build(order_params)

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
      render :edit
    end
  end

  protected
  def order_params
    params.require(:order).permit(:food_id, :user_id, :arrival_time,
      :section_id)
  end

end
