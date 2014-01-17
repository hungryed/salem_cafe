class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user_is_not_employee, except: [:index, :show, :update]

  def index
    if current_user.is_employee?
      @orders = Section.todays_orders(params[:section_id], params[:page])
      @current_section = Section.find(params[:section_id])
    else
      @current_orders = current_user.todays_uncompleted_orders(params[:page])
      @orders = current_user.all_orders(params[:page])
    end
  end

  def new
    @sections = Section.all
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = current_user.orders.build(order_params)
    @section = Section.find(params[:section_id])
    @sections = Section.all
    if @section
      @order.section = @section
    end

    if @order.save
      redirect_to root_path, notice: 'Order placed successfully'
    else
      render :new
    end
  end

  def destroy
    @order = Order.find(params[:id])

    if @order.destroy
      redirect_to root_path, notice: 'Order cancelled'
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @section = Section.find(@order.section)
    if current_user.is_employee?

      respond_to do |format|
        if @order.update_attribute(:status, params[:order][:status])
          format.html { redirect_to section_orders_path(@section) }
          format.json { render json: @order }
        else
          binding.pry
          format.html { redirect_to section_orders_path(@section), notice: 'There was an error.' }
          format.json { render json: @order.errors, status: :unpocessable_entity }
        end
      end
    else
      if @order.update(order_params)
        redirect_to root_path, notice: 'Order changed successfully'
      else
        render :edit
      end
    end
  end

  protected
  def order_params
    params.require(:order).permit(:food_id, :user_id, :arrival_time,
      :section_id, :status)
  end

end
