class RequestsController < ApplicationController

  before_action :authenticate_user!

  def index
    @request = Request.all
  end


  def create
    # Create bi-directional relation
    @request = current_user.requests.build(friend_id: params[:friend_id])
    
    if @request.save && created_relation?(params[:friend_id], current_user.id)
      # notif
      flash[:notice] = "Request is accepted!"
    elsif @request.save
      # notif
      flash[:notice] = "Request is sent!"
    else
      flash[:alert] = "Error!"
    end
    redirect_to "/users"
  end


  def destroy
    # destroy two relationship
    @request = Request.find(params[:id])
    @opposite_request =  Request.find_by(friend_id: current_user.id)
    if created_relation?(params[:friend_id], current_user.id)
      @request.destroy
      @opposite_request.destroy
      flash[:notice] = "friendship is terminated!"
      redirect_to friends_user_path(current_user.id)
      # notif
    elsif @opposite_request.destroy
      flash[:notice] = "request is rejected!"
      redirect_to "/users"
      # notif
    else
      flash[:alert] = "Error!"
    end
  end

  private

  def created_relation?(friend,current_id)
    @created_relation = User.find_by(id: friend).requests.any? do |request|
      request.friend_id == current_id
    end
  end
end
