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
      send_accepted_notification(params[:friend_id])
      flash[:notice] = "Request is accepted!"
    elsif @request.save
      # notif
      send_sent_notification(params[:friend_id])
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
      # notif
      send_terminated_notification(@request.friend_id)
      flash[:notice] = "friendship is terminated!"
      redirect_to friends_user_path(current_user.id)
    elsif @opposite_request.destroy
      # notif
      send_rejected_notification(@request.friend_id)
      flash[:notice] = "request is rejected!"
      redirect_to "/users"
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

  # Notif
  def send_accepted_notification(friend_id)
    @user = User.find_by(id: friend_id)
    @notif = @user.notifications.build(message: "accepted your post.", 
                                      url: posts_url, 
                                      sender_id: current_user.id)
    @notif.save
  end

  def send_sent_notification(friend_id)
    @user = User.find_by(id: friend_id)
    @notif = @user.notifications.build(message: "sent you a friend request.", 
                                      url: posts_url, 
                                      sender_id: current_user.id)
    @notif.save
  end
  
  def send_terminated_notification(friend_id)
    @user = User.find_by(id: friend_id)
    @notif = @user.notifications.build(message: "had terminated the friendship.", 
                                      url: posts_url, 
                                      sender_id: current_user.id)
    @notif.save
  end
  
  def send_rejected_notification(friend_id)
    @user = User.find_by(id: friend_id)
    @notif = @user.notifications.build(message: "rejected your request.", 
                                      url: posts_url, 
                                      sender_id: current_user.id)
    @notif.save
  end


end
