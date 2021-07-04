class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @post = Post.all.order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Post is created!"
      # Send to friends
      send_post_notification(@post)
    else
      flash[:alert] = "Error! Post is not created!"
    end
    redirect_to posts_path
  end

  def show
    # @post = Post.find(params[:id])
  end

  def edit
    # @post = Post.find(params[:id])
    # Need to update new images
  end

  def update
    # Fetch the object first, but it could be achieved through set_post method
    # @post = Post.find(params[:id])
    @post.update(post_params)
    if @post.save
      flash[:notice] = "Post is updated!"
      redirect_to posts_path
    else
      flash[:alert] = "Error! Post is not updated!"
      redirect_to posts_path
    end
  end

  def destroy
    # @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post is deleted!"
    redirect_to posts_path
  end

  # Delete attached image on post 
  def delete_attachment
    @image = ActiveStorage::Attachment.find(params[:image_id])
    @image.purge
    redirect_back(fallback_location: posts_path)
  end

  private
  
  def post_params
    params.require(:post).permit(:user_id, :body, images: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def send_post_notification(post)
    @friends = current_user.friends.all
    @friends.each do |friend|
      @notif = friend.notifications.build(message: "created a new post.", 
                                          url: posts_url, 
                                          sender_id: current_user.id)
      @notif.save                                    
    end
  end
end
