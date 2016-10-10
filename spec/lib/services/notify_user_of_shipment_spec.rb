require 'rails_helper'

describe(NotifyUserOfShipment) do
  let(:user) { create(:user_with_order) }
  let(:order) { user.orders.first }

  describe '#send_notification' do
    context 'when the user prefers email' do
      before do
        user.update_attribute(:notification_preference, 'email')
      end

      it 'sends the user an email notification' do
        delivery_count = ActionMailer::Base.deliveries.count

        NotifyUserOfShipment.new(order).send_notification

        expect(ActionMailer::Base.deliveries.count).to eq delivery_count + 1
      end

      it 'sends the correct email' do
        NotifyUserOfShipment.new(order).send_notification

        mail = ActionMailer::Base.deliveries.last

        expect(mail.to).to include user.email
        expect(mail.subject).to eq 'Your order has shipped!'
      end
    end

    context 'when the user prefers snail mail' do
      before do
        user.update_attribute(:notification_preference, 'mail')
      end

      it 'prints a shipping label' do
        NotifyUserOfShipment.new(order).send_notification

        expect(order.label_status).to eq 'printed'
      end

      it 'sends a notification to the shipping team' do
        delivery_count = ActionMailer::Base.deliveries.count

        NotifyUserOfShipment.new(order).send_notification

        expect(ActionMailer::Base.deliveries.count).to eq delivery_count + 1
      end
    end
  end
end
