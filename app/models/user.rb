class User < ActiveRecord::Base
  validates_format_of :email, with: /.+@.+\..+/i
  validates_uniqueness_of :email
end
