class User < ActiveRecord::Base
  validates_format_of :email, with: /.+@.+\..+/i
  validates_uniqueness_of :email

  has_many :referrals, :class_name => "User", :foreign_key => "referrer_id"
  # belongs_to :referrer, :class_name => "User", :foreign_key => "referrer_id"

  def add_referral(email_address)
    referrals.create(email: email_address)
  end
end
