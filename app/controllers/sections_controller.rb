class SectionsController < ApplicationController
  before_filter :authorize_user_is_admin, except: [:index, :show]
  def new
    @section = Section.new
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])

    if @section.update(section_params)
      redirect_to sections_path
    else
      render :edit
    end
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
