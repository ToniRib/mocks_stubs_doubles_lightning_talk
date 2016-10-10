class NotifyViaText
  def initialize(order)
    @order = order
  end

  def call
    TwilioService.text_shipment_notification(order: @order)

    @order.update_attribute(:texted_at, Date.today)
  end
end
