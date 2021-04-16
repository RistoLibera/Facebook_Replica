class LikingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @liking = Liking.new
  end

  def create
    @liking = current_user.likings.build(post_id: params[:post_id])
    if @liking.save
      flash[:notice] = "Liking is created!"
      redirect_to posts_path
    else
      flash[:alert] = "Error! Liking is not created!"
    end

  end

  def destroy
    @liking = Liking.find(params[:id])
    @liking.destroy
    flash[:notice] = "Liking is deleted!"
    redirect_to posts_path
  end
end
