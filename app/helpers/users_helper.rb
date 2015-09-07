module UsersHelper
  def tweet_link(referral_code, message)
    link_to("http://twitter.com/share?url=#{CGI::escape root_url}&ref=#{CGI::escape referral_code}&text=#{CGI::escape message}".html_safe, class: 'twit', target: '_blank') {}
  end
end
