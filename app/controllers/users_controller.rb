class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    redirect_to referrals_path
  end
end
