class NotifyViaSnailMail
  def initialize(order)
    @order = order
  end

  def call
    print_shipping_label
    send_notification_to_shipping_team
  end

  private

  attr_reader :order

  def print_shipping_label
    Printer.print_shipping_label(name: user.full_name, address: user.shipping_address)
  end

  def send_notification_to_shipping_team
    TeamNotifier.notify_shipping_of_pending_delivery(order: order)
  end

  def user
    @user ||= order.user
  end
end
