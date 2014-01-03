class FoodsController < ApplicationController

  def new
    @food = Food.new
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
    params.require(:food).permit(:name, :description, :picture)
  end
end
