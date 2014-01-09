class SectionsController < ApplicationController
  before_filter :authorize_user_is_admin, except: [:index, :show]
  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)

    if @section.save
      redirect_to root_path, notice: 'Section added successfully'
    else
      render :new
    end
  end

  def index
    @sections = Section.all
  end

  protected
  def section_params
    params.require(:section).permit(:name, :description)
  end

end
