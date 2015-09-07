require "rails_helper"

RSpec.describe UsersHelper, :type => :helper do
  describe "#tweet_link" do
    let(:referral_code) { 'abcd1234' }
    let(:message) { 'tweet message' }
    it "returns a twitter link with the referral code" do
      expect(helper.tweet_link(referral_code, message)).to eq('<a class="twit" target="_blank" href="http://twitter.com/share?url=http%3A%2F%2Ftest.host%2F&ref=abcd1234&text=tweet+message"></a>')
    end
  end
end
