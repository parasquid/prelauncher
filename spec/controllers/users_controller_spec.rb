require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:test_email) { 'test@example.com'}
  describe "GET new" do
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    it "redirects to referral page" do
      post :create, email: test_email
      expect(response).to redirect_to(referrals_path)
    end

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

    it "saves the user id in a cookie" do
      post :create, email: test_email
      expect(cookies.signed["user_id"]).to eq assigns[:user].id
    end

    context "new user" do
      it "creates a new account" do
        post :create, email: test_email
        expect(User.count).to eq 1
      end

      it "saves the account" do
        post :create, email: test_email
        expect(assigns(:user)).to be_persisted
      end
    end
  end

  describe "GET refer-a-friend" do
  end
end
