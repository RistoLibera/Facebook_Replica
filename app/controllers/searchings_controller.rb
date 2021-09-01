class SearchingsController < ApplicationController

  def create
    @word = searching_params[:word]
    @searching = current_user.searchings.build(word: @word)
    flash[:notice] = "New searching is performed!" if @searching.save
    @users = User.where("firstname ILIKE ? OR lastname ILIKE ?", "%#{@word}%", "%#{@word}%")
    @posts = Post.where("body ILIKE ?", "%#{@word}%")
    render :index
  end

  def index
    if current_user.searchings.any?
      @word = current_user.searchings.last.word
      @users = User.where("firstname ILIKE ? OR lastname ILIKE ?", "%#{@word}%", "%#{@word}%")
      @posts = Post.where("body ILIKE ?", "%#{@word}%")
    else
      @users = nil
      @posts = nil
    end
  end 

  def destroy
    @search = current_user.searchings.find(params[:id])
    if @search.destroy
      flash[:notice] = "Searching is deleted!"
      redirect_back fallback_location: posts_path
    else
      render 'index'
    end

  end

  private

  def searching_params
    params.require(:searching).permit(:word)
  end
end
