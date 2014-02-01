class UsersController < ApplicationController
  before_filter :current_page_is_user_own_profile

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to user_path(@user), notice: 'Profile updated successfully'
    else
      render :edit
    end
  end

  protected
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
