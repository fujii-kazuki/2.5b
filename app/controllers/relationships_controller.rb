class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    unless Relationship.exists?(follower_id: current_user.id, followed_id: params[:user_id])
      relationship = Relationship.new(follower_id: current_user.id, followed_id: params[:user_id])
      relationship.save
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if Relationship.exists?(follower_id: current_user.id, followed_id: params[:user_id])
      relationship = Relationship.find_by(follower_id: current_user.id, followed_id: params[:user_id])
      relationship.destroy
    end
    redirect_back(fallback_location: root_path)
  end

  def following
     @following_users = User.find(params[:user_id]).following_users
  end

  def followed
     @followed_users = User.find(params[:user_id]).followed_users
  end
end
