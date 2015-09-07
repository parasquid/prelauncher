module UsersHelper

  TWITTER_SHARE_URL = 'http://twitter.com/share'
  FACEBOOK_SHARE_URL = 'http://www.facebook.com/sharer/sharer.php'

  def tweet_link(referral_code, message)
    url = CGI::escape root_url
    ref = CGI::escape referral_code
    text = CGI::escape message
    link_to("#{TWITTER_SHARE_URL}?url=#{url}&ref=#{ref}&text=#{text}".html_safe, class: 'twit', target: '_blank') {}
  end

  def fb_link(referral_code, message)
    url = CGI::escape root_url
    ref = CGI::escape referral_code
    text = CGI::escape message
    link_to("#{FACEBOOK_SHARE_URL}?u=#{url}&ref=#{ref}&title=#{text}".html_safe, class: 'fb', target: '_blank') {}
  end
end
