class Address < ActiveRecord::Base
  belongs_to :user

  def to_s
    "#{street_address} #{city}, #{state} #{zipcode}"
  end
end
