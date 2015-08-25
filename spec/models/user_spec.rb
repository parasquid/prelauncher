require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when a guest signs up' do
    let(:test_email) { 'test@example.com'}
    it 'creates a user account' do
      User.create(email: test_email)
      expect(User.count).to eq 1
    end
    context 'with an invalid email' do
      describe 'no domain' do
        let(:invalid_email) { 'test@' }
        it 'does not create an account' do
          User.create(email: invalid_email)
          expect(User.count).to eq 0
        end
      end
      describe 'no @ sign' do
        let(:invalid_email) { 'test.example.com' }
        it 'does not create an account' do
          User.create(email: invalid_email)
          expect(User.count).to eq 0
        end
      end
      describe 'no local part' do
        let(:invalid_email) { '@example.com' }
        it 'does not create an account' do
          User.create(email: invalid_email)
          expect(User.count).to eq 0
        end
      end
    end
    context 'with a duplicate email' do
      it 'does not create an account' do
        User.create(email: test_email)
        User.create(email: test_email)
        expect(User.count).to eq 1
      end
    end
  end
end
