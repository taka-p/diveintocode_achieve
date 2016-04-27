class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :js

  def create
    @user = User.find(params[:relationship][:followed_id])
    if current_user.id == @user.id
      render 'relationships/create'
      return
    end
    current_user.follow!(@user)
    respond_with @user
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    if current_user.id == @user.id
      render 'relationships/destroy'
      return
    end
    current_user.unfollow!(@user)
    respond_with @user
  end
end
