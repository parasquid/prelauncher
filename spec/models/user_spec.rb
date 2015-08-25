require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'when a guest signs up' do
    it 'creates a user account' do
      expect(User.count).to eq 1
    end
    it 'does not allow another user account to have the same email address'
  end
end
