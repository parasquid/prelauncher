class UsersController < ApplicationController
  before_filter :check_if_already_registered, only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.new(email: params[:email])
    @user.save
    cookies.permanent.signed[:user_id] = @user.id
    redirect_to referrals_path
  end

  def refer
    @user = User.find(cookies.signed["user_id"])
    @referral_code = @user.referral_code
  end

  private

  def check_if_already_registered
    if cookies.signed["user_id"]
      already_registered = User.where(id: cookies.signed["user_id"]).first
      if already_registered
        redirect_to referrals_path
      else
        cookies.delete("user_id")
      end
    end
  end

end
