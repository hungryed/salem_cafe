class MenusController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user_is_employee

  def index
    @sections = Section.all
  end

  def create
    active_foods = find_active_food_ids
    inactive_foods = find_inactive_food_ids
    section = Section.find(params[:section_id])
    if Food.set_food_to_active(active_foods) && Food.set_food_to_inactive(inactive_foods)
      redirect_to root_path, notice: "Menu updated successfully for #{section.name}"
    else
      redirect_to root_path, notice: "There was an error."
    end
  end

  private
  def find_active_food_ids
    params[:active_foods][:foods].select { |food, value| value == "1" }.keys
  end

  def find_inactive_food_ids
    params[:active_foods][:foods].select { |food, value| value == "0" }.keys
  end
end
