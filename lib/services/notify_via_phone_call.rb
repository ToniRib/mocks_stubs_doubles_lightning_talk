class NotifyViaPhoneCall
  def initialize(order)
    @order = order
  end

  def call
    AutomatedPhoneService.notify_of_shipment(order: @order)
  end
end
