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
      redirect_to posts_path
    else
      flash[:alert] = "Error! Post is not created!"
      render :new
    end
  end

  def show
    # @post = Post.find(params[:id])
  end

  def edit
    # @post = Post.find(params[:id])
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
      render :edit
    end
  end

  def destroy
    # @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Post is deleted!"
    redirect_to posts_path
  end


  private
  
  def post_params
    params.require(:post).permit(:user_id, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
