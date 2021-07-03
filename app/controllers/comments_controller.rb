class CommentsController < ApplicationController
  before_action :set_comment, only: [ :edit, :update, :destroy]
  
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "Comment is created!"
      redirect_to posts_path
    else
      flash[:alert] = "Error! Comment is not created!"
      redirect_to posts_path
    end
  end

  def edit
  end

  def update
    @comment.update(comment_params)
    if @comment.save
      flash[:notice] = "Comment is updated!"
      redirect_to posts_path
    else
      flash[:alert] = "Error! Comment is not updated!"
      render :edit
    end
  end

  def destroy
    @comment.destroy
    flash[:notice] = "Comment is deleted!"
    redirect_to posts_path
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
