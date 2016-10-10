class NotifyViaSnailMail
  def initialize(order)
    @order = order
  end

  def call
    print_envelope_with_address
    print_notification_letter
    send_notification_to_shipping_team
  end

  private

  attr_reader :order

  def print_envelope_with_address
    Printer.print_envelope(name: user.full_name, address: user.shipping_address)

    order.update_attribute(:label_status, 'printed')
  end

  def print_notification_letter
    Printer.print_notification_letter(order: order)
  end

  def send_notification_to_shipping_team
    NotificationMailer.notify_shipping_letter_is_ready(order: order).deliver_now
  end

  def user
    @user ||= order.user
  end
end
