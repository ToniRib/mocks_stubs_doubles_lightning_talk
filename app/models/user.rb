class User < ActiveRecord::Base
  belongs_to :company

  has_many :addresses
end
