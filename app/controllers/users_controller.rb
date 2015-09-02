class UsersController < ApplicationController
  def new
    redirect_if_already_registered
    @user = User.new

    ref_code = params[:ref_code]
    cookies.permanent.signed["ref_code"] = ref_code
  end

  def create
    email = params[:user][:email]
    referring_user = find_referring_user

    if referring_user
      @user = referring_user.add_referral(email)
    else
      @user = User.new(email: email)
      @user.save
    end

    @user = User.where(email: email).first
    cookies.permanent.signed["user_id"] = @user.id
    redirect_to referrals_path
  end

  def refer
    @user = User.where(id: cookies.signed["user_id"]).first
    if !@user.nil?
      @referral_code = @user.referral_code
    else
      redirect_to root_path
    end
  end

  private

  def redirect_if_already_registered
    if cookies.signed["user_id"]
      already_registered = User.where(id: cookies.signed["user_id"]).first
      if already_registered
        redirect_to referrals_path
      else
        cookies.delete("user_id")
      end
    end
  end

  def find_referring_user
    ref_code = cookies.permanent.signed["ref_code"]
    User.where(referral_code: ref_code).first
  end

end
