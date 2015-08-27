require 'rails_helper'

RSpec.describe User, type: :model do
  let(:test_email) { 'test@example.com'}

  context 'when a guest signs up' do
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

  context 'referrals' do
    describe 'when there is a referral' do
      let(:this_user) { User.create(email: test_email) }
      let(:referral_email) { 'referral@example.com' }
      let(:referral) { this_user.add_referral(email: referral_email) }
      it 'is able to store a referral' do
        expect(referral).to_not be nil
      end
      it 'counts the number of referrals this user has' do
        referral # force-load the lazily-instantiated variable
        expect(this_user.referrals.count).to eq 1
      end
      it 'correctly tracks the referral and the user that referred it' do
        expect(referral.referrer).to eq this_user
      end
    end
  end
end
