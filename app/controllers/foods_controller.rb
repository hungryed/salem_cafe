class FoodsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user_is_employee, except: [:index, :show]

  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def show
    @food = Food.find(params[:id])
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])

    if @food.update(food_params)
      redirect_to foods_path, notice: 'Food Item updated successfully'
    else
      render :edit
    end
  end

  def create
    @food = Food.new(food_params)

    if @food.save
      redirect_to root_path, notice: 'Food Item added'
    else
      render :new
    end
  end

  protected
  def food_params
    params.require(:food).permit(:name, :description, :picture, :section_id )
  end
end
