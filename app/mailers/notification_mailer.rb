class NotificationMailer < ActionMailer::Base
  def send_shipment_email(order:)
    @order = order

    mail subject: 'Your order has shipped!',
         to:      @order.user.email,
         from:    'example@shipping.com'
  end
end
