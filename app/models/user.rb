class User < ActiveRecord::Base
  validates_format_of :email, with: /.+@.+\..+/i
  validates_uniqueness_of :email

  def add_referral(email_address)
    self
  end
end
