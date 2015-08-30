require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:test_email) { 'test@example.com'}

  describe "GET new" do
    let(:user) { User.create(email: test_email) }

    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end

    it "redirectes to the referrals page if this user is cookied" do
      cookies.signed["user_id"] = user.id
      get :new
      expect(response).to redirect_to(referrals_path)
    end

    it "deletes the cookie if there is no user found with the cookied id" do
      cookies.signed["user_id"] = 42
      get :new
      expect(cookies.has_key?("user_id")).to be false
    end
  end

  describe "POST create" do
    context "cookie properties" do
      let(:biscuits) { double(cookies) }

      before do
        allow(biscuits).to receive(:"[]=")
        allow(biscuits).to receive(:permanent).and_return(biscuits)
        allow(biscuits).to receive(:signed).and_return(biscuits)
        allow(controller).to receive(:cookies).and_return(biscuits)
      end

      it "saves the user_id in a signed cookie" do
        post :create, email: test_email
        expect(biscuits).to have_received(:signed)
      end

      it "saves the user_id in a permanent cookie" do
        post :create, email: test_email
        expect(biscuits).to have_received(:permanent)
      end

    end

    context "next steps" do
      before do
        post :create, email: test_email
      end

      it "redirects to referral page" do
        post :create, email: test_email
        expect(response).to redirect_to(referrals_path)
      end

      it "saves the user id in a cookie" do
        post :create, email: test_email
        expect(cookies.signed["user_id"]).to eq assigns[:user].id
      end
    end

    context "new user" do
      before do
        post :create, email: test_email
      end

      it "creates a new account" do
        expect(User.count).to eq 1
      end

      it "saves the account" do
        expect(assigns(:user)).to be_persisted
      end
    end
  end

  describe "GET refer-a-friend" do
    let(:user) { User.create(email: test_email) }

    context "with a signed-in user" do
      before do
        cookies.signed["user_id"] = user.id
      end

      it "contains the user's referral id" do
        get :refer
        expect(assigns[:referral_code]).to include(user.referral_code)
      end
    end

    context "with a non signed-in user" do
      it "redirects to the sign-in page" do
        get :refer
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
