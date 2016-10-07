class User < ActiveRecord::Base
  belongs_to :company

  has_many :addresses
  has_many :orders
  has_many :items, through: :order_items

  def prefers_email?
    notification_preference == 'email'
  end

  def prefers_snail_mail?
    notification_preference == 'mail'
  end

  def prefers_text?
    notification_preference == 'text'
  end

  def prefers_phone_call?
    notification_preference == 'phone'
  end
end
