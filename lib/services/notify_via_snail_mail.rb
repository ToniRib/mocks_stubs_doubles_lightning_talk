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
    order.update_attribute(:label_status, 'printed')
  end

  def send_notification_to_shipping_team
    NotificationMailer.notify_shipping_of_pending_delivery(order: order).deliver_now
  end

  def user
    @user ||= order.user
  end
end
