require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { build_stubbed(User) }
  describe "GET new" do
    let(:user) { build_stubbed(User) }
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end
  end
end
