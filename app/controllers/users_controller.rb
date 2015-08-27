class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(email: params[:email])
    @user.save
    redirect_to referrals_path
  end
end
