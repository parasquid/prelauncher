class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(email: params[:email])
    @user.save
    cookies.permanent.signed[:user_id] = @user.id
    redirect_to referrals_path
  end
end
