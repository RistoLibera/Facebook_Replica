class LikingsController < ApplicationController
  def new
  end

  def create
    @liking = current_user.likings.build
  end

  def destroy
  end
end
