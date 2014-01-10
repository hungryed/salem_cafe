class FoodCategoriesController < ApplicationController

  def index
    @section = Section.find(params[:section_id])
    @food_categories = @section.food_categories
  end

  def new
    @section = Section.find(params[:section_id])
    @food_category = FoodCategory.new
  end

  def create
    @food_category = FoodCategory.new(food_category_params)
    @section = Section.find(params[:section_id])
    @food_category.section = @section

    if @food_category.save
      redirect_to root_path, notice: 'Category created successfully'
    else

    end
  end

  protected
  def food_category_params
    params.require(:food_category).permit(:name,:description)
  end
end
