class Printer
  def self.print_envelope(name:, address:)
    puts "Printing envelope for #{name} with address: #{address}"
  end

  def self.print_notification_letter(order:)
    puts "Printing notification letter for Order #: #{order.id}"
  end
end
