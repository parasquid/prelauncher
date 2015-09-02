class User < ActiveRecord::Base
  validates_format_of :email, with: /.+@.+\..+/i
  validates_uniqueness_of :email
  validates_uniqueness_of :referral_code

  has_many :referrals, :class_name => "User", :foreign_key => "referrer_id"
  belongs_to :referrer, :class_name => "User", :foreign_key => "referrer_id"

  before_create :generate_referral_code

  def add_referral(email_address)
    self.referrals.create(email: email_address)
  end

  def generate_referral_code
    self.referral_code = SecureRandom.hex(5)
  end
end
