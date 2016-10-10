require 'rails_helper'

describe(NotifyUserOfShipment) do
  let(:user) { create(:user_with_order) }
  let(:order) { user.orders.first }

  describe '#send_notification' do
    context 'when the user prefers email' do
      it 'sends the user an email notification' do
        user.update_attribute(:notification_preference, 'email')

        expect { NotifyUserOfShipment.new(order).send_notification }
          .to change { ActionMailer::Base.deliveries.count }
          .by(1)
      end
    end
  end
end
