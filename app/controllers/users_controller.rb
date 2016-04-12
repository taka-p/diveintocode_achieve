class UsersController < ApplicationController
  def index
    @users = User.all.reverse_order
  end

  def show
    @user = User.find(params[:id])
  end
end
