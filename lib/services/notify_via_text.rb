class NotifyViaText
  def initialize(order)
    @order = order
  end

  def call
    TwilioService.text_shipment_notification(order: @order)
  end
end
