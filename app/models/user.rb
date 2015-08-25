class User < ActiveRecord::Base
  validates_format_of :email, with: /.+@.+\..+/i
end
