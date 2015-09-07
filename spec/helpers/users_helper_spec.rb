require "rails_helper"

RSpec.describe UsersHelper, :type => :helper do
  let(:host) { CGI::escape 'http://test.host/' }
  let(:referral_code) { 'abcd1234' }
  let(:message) { 'message' }

  describe "#tweet_link" do
    let(:share_url) { 'http://twitter.com/share' }
    it "returns a twitter link" do
      href = "#{share_url}?url=#{host}&ref=#{referral_code}&text=#{message}"
      expect(helper.tweet_link(referral_code, message)).to eq("<a class=\"twit\" target=\"_blank\" href=\"#{href}\"></a>")
    end
  end

  describe "#fb_link" do
    let(:share_url) { 'http://www.facebook.com/sharer/sharer.php' }
    it "returns an fb link" do
      href = "#{share_url}?u=#{host}&ref=#{referral_code}&title=#{message}"
      expect(helper.fb_link(referral_code, message)).to eq("<a class=\"fb\" target=\"_blank\" href=\"#{href}\"></a>")
    end
  end
end
