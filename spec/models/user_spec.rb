require 'rails_helper'

RSpec.describe User, type: :model do
  let(:test_email) { 'test@example.com'}
  let(:another_email) { 'another@example.com' }

  context 'data reporting' do
    it 'retrieves the most recent records first' do
      user = User.create(email: test_email)
      another_user = User.create(
        email: another_email,
        created_at: Time.now + 1.hour
      )
      expect(User.first).to eq(another_user)
    end
  end

  context 'when a guest signs up' do
    it 'creates a user account' do
      User.create(email: test_email)
      expect(User.count).to eq 1
    end

    context 'with an invalid email' do
      describe 'with no domain' do
        let(:invalid_email) { 'test@' }
        it 'does not create an account' do
          User.create(email: invalid_email)
          expect(User.count).to eq 0
        end
      end

      describe 'with no @ sign' do
        let(:invalid_email) { 'test.example.com' }
        it 'does not create an account' do
          User.create(email: invalid_email)
          expect(User.count).to eq 0
        end
      end

      describe 'with no local part' do
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
    let(:this_user) { User.create(email: test_email) }

    describe 'when there is a referral' do
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

    describe 'generating referral codes' do
      it 'is able to create a referral code' do
        this_user.generate_referral_code
        expect(this_user.referral_code).to_not be nil
      end

      let(:another_user) { User.create(email: another_email) }
      it 'generates a unique referral code' do
        another_user.generate_referral_code
        this_user.generate_referral_code
        expect(this_user.referral_code).to_not eq(another_user.referral_code)
      end

      it 'generates a referral code as soon as an account is created' do
        expect(this_user.referral_code).to_not be nil
      end
    end
  end
end
