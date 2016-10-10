class User < ActiveRecord::Base
  belongs_to :company

  has_many :addresses
  has_many :orders

  def prefers_email?
    notification_preference == 'email'
  end

  def prefers_snail_mail?
    notification_preference == 'mail'
  end

  def prefers_text?
    notification_preference == 'text'
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def shipping_address
    addresses.find_by(type_of: 'shipping').to_s
  end
end
