class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
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

  def clear
    # Clear notification
    @user = User.find(params[:id])
    @user.notifications.each { |notif| notif.seen! } if @user.notifications.any?
    redirect_back fallback_location: posts_path
  end


  private

  def user_params
    params.require(:user).permit()
  end

end
