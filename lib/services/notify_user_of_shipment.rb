class NotifyUserOfShipment
  def initialize(order)
    @order = order
  end

  def send_notification
    if user.prefers_email?
      NotifyViaEmail.new(order).call
    elsif user.prefers_snail_mail?
      NotifyViaSnailMail.new(order).call
    elsif user.prefers_text?
      NotifyViaText.new(order).call
    end
  end

  private

  attr_reader :order, :user

  def user
    @user ||= order.user
  end
end
