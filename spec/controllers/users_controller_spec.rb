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

    context "new user" do
      before do
        user = double(User)
        allow(user).to receive(:save).and_return(true)
        allow(User).to receive(:new).and_return(user)
      end

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
end
