class NotifyViaEmail
  def initialize(order)
    @order = order
  end

  def call
    NoficationMailer.send_shipment_email(order: @order)
  end
end
