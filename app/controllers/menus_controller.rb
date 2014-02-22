class MenusController < ApplicationController

  def index
    @sections = Section.all
  end

  def create
    active_foods = find_active_food_ids
    section = Section.find(params[:section_id])
    if set_foods_to_active(active_foods)
      redirect_to root_path, notice: "Menu updated successfully for #{section.name}"
    else

    end
  end

  private
  def find_active_food_ids
    params[:active_foods][:foods].select { |food, value| value == "1" }.keys
  end

  def set_foods_to_active(active_foods)
    returns = []
    active_foods.each do |food_id|
      food = Food.find(food_id)
      food.on_menu = true
      if food.save
        returns << true
      else
        returns << false
      end
    end
    !returns.include?(false)
  end
end
