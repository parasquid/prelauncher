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
    let(:user_id) { 1337 }
    let(:user) { double(User) }

    before do
      allow(User).to receive(:new).and_return(user)
      allow(user).to receive(:save).and_return(true)
      allow(user).to receive(:id).and_return(user_id)
    end

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
      expect(cookies.signed["user_id"]).to eq user_id
    end

    context "new user" do

      it "creates a new account" do
        post :create, email: test_email
        expect(User).to have_received(:new).with(email: test_email)
      end

      it "saves the account" do
        post :create, email: test_email
        expect(assigns(:user)).to have_received(:save)
      end
    end
  end

  describe "GET refer-a-friend" do
  end
end
