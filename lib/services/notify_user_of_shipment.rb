class NotifyUserOfShipment
  def initialize(order)
    @order = order
  end

  def send_notification
    service = if user.prefers_email?
                NotifyViaEmail.new(order)
              elsif user.prefers_snail_mail?
                NotifyViaSnailMail.new(order)
              elsif user.prefers_text?
                NotifyViaText.new(order)
              end

    service.call
  end

  private

  attr_reader :order, :user

  def user
    @user ||= order.user
  end
end
