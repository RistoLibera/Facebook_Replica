class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])

  end

  def update
  end


  def index
    @user = User.all
  end

  def about
    @user = User.find(params[:id])
  end

  def friends
    @user = User.find(params[:id])
  end


  private

  def user_params
    params.require(:user).permit()
  end

end
