class NotifyViaEmail
  def initialize(order)
    @order = order
  end

  def call
    NotificationMailer.send_shipment_email(order: @order).deliver_now
  end
end
