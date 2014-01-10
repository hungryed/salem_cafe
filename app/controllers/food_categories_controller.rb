class FoodCategoriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user_is_employee

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
      render :new
    end
  end

  def edit
    @food_category = FoodCategory.find(params[:id])
    @section = Section.find(params[:section_id])
  end

  def update
    @food_category = FoodCategory.find(params[:id])
    @section = Section.find(params[:section_id])

    if @food_category.update(food_category_params)
      redirect_to root_path, notice: 'Category updated successfully'
    else
      render :edit
    end
  end

  protected
  def food_category_params
    params.require(:food_category).permit(:name,:description)
  end
end
