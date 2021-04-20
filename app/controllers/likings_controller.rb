class LikingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @liking = Liking.new
  end

  def create
    @liking = current_user.likings.build(post_id: params[:post_id])
    if @liking.save
      flash[:notice] = "Liking is created!"
      # notif
      send_liking_notification(params[:post_id])
    else
      flash[:alert] = "Error! Liking is not created!"
    end
    redirect_to posts_path
  end

  def destroy
    @liking = Liking.find(params[:id])
    @liking.destroy
    flash[:notice] = "Liking is deleted!"
    redirect_to posts_path
  end

  private

  def send_liking_notification(post_id)
    @post = Post.find_by(id: post_id)
    @user = User.find_by(id: @post.user_id) 
    @notif = @user.notifications.build(message: "liked your post.", 
                                      url: posts_url, 
                                      sender_id: current_user.id)
    @notif.save
  end
end
