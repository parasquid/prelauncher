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

    pending context "new user" do
      it "creates a new account" do
        allow_any_instance_of(User).to receive(:save).and_return(true)
        post :create, email: test_email
        expect(User).to receive(:save)
      end
    end
  end
end
