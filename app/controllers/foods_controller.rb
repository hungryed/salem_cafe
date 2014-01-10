class FoodsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user_is_employee, except: [:index, :show]

  def index
    @section = Section.find(params[:section_id])
    @foods = @section.foods
  end

  def new
    @section = Section.find(params[:section_id])
    @food = Food.new
  end

  def show
    @section = Section.find(params[:section_id])
    @food = Food.find(params[:id])
  end

  def edit
    @section = Section.find(params[:section_id])
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])
    @section = Section.find(params[:section_id])

    if @food.update(food_params)
      redirect_to root_path, notice: 'Food Item updated successfully'
    else
      render :edit
    end
  end

  def create
    @food = Food.new(food_params)
    @section = Section.find(params[:section_id])
    if @food.save
      redirect_to root_path, notice: 'Food Item added'
    else
      render :new
    end
  end

  protected
  def food_params
    params.require(:food).permit(:name, :description, :picture,
      :section_id, :food_category_id)
  end
end
