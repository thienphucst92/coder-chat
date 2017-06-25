class RelationshipsController < ApplicationController

  def create
    @friendship = current_user.relationships.build(friend_id: params[:friend_id].to_i, status: "pending")

    if @friendship.save
      flash[:notice] = "Sended friend request"
      redirect_to users_path
    else
      flash[:error] = "Unable to send friend request"
      redirect_to users_path
    end
  end

  def accept_friend_request
    @friendship = current_user.inverse_relationships.where(user_id: params[:friend_id]).take
    @friendship.status = 'friend'
    @friendship.save

    @friendship = current_user.relationships.build(friend_id: params[:friend_id].to_i, status: 'friend')
    @friendship.save

    redirect_to users_path
  end

end
