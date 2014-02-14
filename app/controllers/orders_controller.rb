class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user_is_not_employee, except: [:index, :show, :update]
  before_filter :current_user_is_page_user, only: [:new, :destroy, :edit]
  before_filter :current_user_is_order_holder, only: :index

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
    @sections = Section.all.sort_by {|s| s.name }
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    set_food_params
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
      order_status = params[:order][:status]
      respond_to do |format|
        if @order.update_attribute(:status, order_status)
          TextMessager.send_text(@order.user) if order_status == 'in progress'
          format.html { redirect_to section_orders_path(@section) }
          format.json { render json: @order }
        else
          format.html { redirect_to section_orders_path(@section), notice: 'There was an error.' }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    else
      set_food_params
      if @order.update(order_params)
        redirect_to root_path, notice: 'Order changed successfully'
      else
        if @order.foods.empty?
          @order.errors.add(:food, "Food can't be blank")
        end
        render :edit
      end
    end
  end

  protected
  def order_params
    params.require(:order).permit(:user_id, :arrival_time,
      :section_id, :status, food_ids: [])
  end

  def set_food_params
    params[:order][:food_ids] = params[:order][:foods].values
  end

end
