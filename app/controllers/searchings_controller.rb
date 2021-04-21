class SearchingsController < ApplicationController

  def create
    @word = searching_params[:word]
    @searching = current_user.searchings.build(word: @word)
    flash[:notice] = "#{@searching.valid?}" 
    @users_email = User.where("email LIKE ?", "%#{@word}%")
    @posts = Post.where("body LIKE ?", "%#{@word}%")
    render :index
  end

  def index
    @users_email = User.where("email LIKE ?", @search_word)
    @posts = Post.where("body LIKE ?", "%#{@search_word}%")
  end 

  def destroy
    @search = current_user.searches.find(params[:id])
    if search.destroy
      flash[:notice] = "Searching is deleted!"
      redirect_to searches_path
    else
      render 'index'
    end

  end

  # Book.where("title LIKE ?", "%" + params[:q] + "%")
  private

  def searching_params
    params.require(:searching).permit(:word)
  end

end
