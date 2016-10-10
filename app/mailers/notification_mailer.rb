class NotificationMailer < ActionMailer::Base
  def send_shipment_email(order:)
    @order = order

    mail subject: 'Your order has shipped!',
         to:      @order.user.email,
         from:    'shipping_notifier@shipit.com'
  end

  def notify_shipping_of_pending_delivery(order:)
    @order = order

    mail subject: 'NOTICE: Order ready to be shipped!',
         to:      'shipping_team@shipit.com',
         from:    'shipping_notifier@shipit.com'
  end
end
