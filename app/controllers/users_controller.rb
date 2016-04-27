class UsersController < ApplicationController
  def index
    @users_total = User.all
    @users = User.page(params[:page]).reverse_order
    @users_left = User.page(params[:page]).limit(10).reverse_order
    @users_right = User.page(params[:page]).limit(10).offset(10).reverse_order
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    current_user.update(update_params)
  end

  def following
    @user = User.find(params[:id])
    @users = @users_total = @user.followed_users
    @users_left = @user.followed_users.limit(10)
    @users_right = @user.followed_users.limit(10).offset(10)
    render 'users/index'
  end

  def followers
    @user = User.find(params[:id])
    @users = @users_total = @user.followers
    @users_left = @user.followers.limit(10)
    @users_right = @user.followers.limit(10).offset(10)
    render 'users/index'
  end

  private

    def update_params
      params.require(:user).permit(:name, :profile)
    end
end
