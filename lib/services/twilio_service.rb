class TwilioService
  def self.text_shipment_notification(order:)
    puts "Texting order notification to: #{order.user.full_name}"
  end
end
