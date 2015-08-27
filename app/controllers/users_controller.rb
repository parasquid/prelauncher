class UsersController < ApplicationController
  before_filter :already_registered, only: :new

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

  def already_registered
    if cookies.signed["user_id"]
      cookied_user = User.where(id: cookies.signed["user_id"]).first
      if cookied_user
        redirect_to referrals_path
      else
        cookies.delete("user_id")
      end
    end
  end

end
