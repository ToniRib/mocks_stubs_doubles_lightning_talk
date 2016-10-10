require 'rails_helper'

# ==================================================
# SCENARIO 1: Let's put everything in the database!!
# ==================================================

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

      it 'prints a envelope/label' do
        NotifyUserOfShipment.new(order).send_notification

        expect(order.label_status).to eq 'printed'
      end

      it 'sends a notification to the shipping team' do
        delivery_count = ActionMailer::Base.deliveries.count

        NotifyUserOfShipment.new(order).send_notification

        expect(ActionMailer::Base.deliveries.count).to eq delivery_count + 1
      end

      it 'sends the correct email' do
        NotifyUserOfShipment.new(order).send_notification

        mail = ActionMailer::Base.deliveries.last

        expect(mail.to).to include 'shipping_team@shipit.com'
        expect(mail.subject).to eq 'NOTICE: Notification Letter Ready For Mailing!'
      end
    end

    context 'when the user prefers a text' do
      before do
        user.update_attribute(:notification_preference, 'text')
      end

      it 'sends a text via Twilio to the user' do
        NotifyUserOfShipment.new(order).send_notification

        expect(order.texted_at).to eq Date.today
      end
    end
  end
end

# ==================================================
# SCENARIO 2: Let's use doubles for all objects!!
# ==================================================

describe(NotifyUserOfShipment) do
  describe '#send_notification' do
    context 'when the user prefers email' do
      let(:user) do
        instance_double(User, prefers_email?: true,
                              email:          'test@example.com',
                              full_name:      'Test User')
      end
      let(:item) do
        instance_double(Item, name:        't-shirt',
                              description: 'awesome')
      end
      let(:order) do
        instance_double(Order, user:             user,
                               items:            [item],
                               shipping_address: '84 Acoma St Denver, CO 80231')
      end

      it 'sends the user an email notification' do
        expect { NotifyUserOfShipment.new(order).send_notification }
          .to change { ActionMailer::Base.deliveries.count }
          .by(1)
      end

      it 'sends the correct email' do
        NotifyUserOfShipment.new(order).send_notification

        mail = ActionMailer::Base.deliveries.last

        expect(mail.to).to include user.email
        expect(mail.subject).to eq 'Your order has shipped!'
      end
    end

    context 'when the user prefers snail mail' do
      let(:user) do
        instance_double(User, prefers_email?:      false,
                              prefers_snail_mail?: true,
                              shipping_address:    '84 Acoma St Denver, CO 80231',
                              full_name:           'Test User')
      end
      let(:item) do
        instance_double(Item, name:        't-shirt',
                              description: 'awesome')
      end
      let(:order) do
        instance_double(Order, user:             user,
                               items:            [item],
                               shipping_address: '84 Acoma St Denver, CO 80231',
                               id: 1)
      end

      it 'prints an envelope/label' do
        expect(order).to receive(:update_attribute).with(:label_status, 'printed')

        NotifyUserOfShipment.new(order).send_notification
      end

      it 'sends a notification to the shipping team' do
        allow(order).to receive(:update_attribute).with(:label_status, 'printed')

        expect { NotifyUserOfShipment.new(order).send_notification }
          .to change { ActionMailer::Base.deliveries.count }
          .by(1)
      end

      it 'sends the correct email' do
        allow(order).to receive(:update_attribute).with(:label_status, 'printed')

        NotifyUserOfShipment.new(order).send_notification

        mail = ActionMailer::Base.deliveries.last

        expect(mail.to).to include 'shipping_team@shipit.com'
        expect(mail.subject).to eq 'NOTICE: Notification Letter Ready For Mailing!'
      end
    end

    context 'when the user prefers a text' do
      let(:user) do
        instance_double(User, prefers_email?:      false,
                              prefers_snail_mail?: false,
                              prefers_text?:       true,
                              full_name:           'Test User')
      end
      let(:order) do
        instance_double(Order, user: user)
      end

      it 'sends a text via Twilio to the user' do
        expect(order).to receive(:update_attribute).with(:texted_at, Date.today)

        NotifyUserOfShipment.new(order).send_notification
      end
    end
  end
end

# ==================================================
# SCENARIO 3: Let's only test this class's logic!!
# ==================================================

describe(NotifyUserOfShipment) do
  describe '#send_notification' do
    let(:order) { instance_double(Order, user: user) }
    let(:notification_service) { double(:notification_service) }

    context 'when the user prefers email' do
      let(:user) do
        instance_double(User, prefers_email?: true)
      end

      it 'calls the NotifyViaEmail service' do
        expect(NotifyViaEmail)
          .to receive(:new)
          .with(order)
          .and_return(notification_service)
        expect(notification_service).to receive(:call)

        NotifyUserOfShipment.new(order).send_notification
      end
    end

    context 'when the user prefers snail mail' do
      let(:user) do
        instance_double(User, prefers_email?:      false,
                              prefers_snail_mail?: true)
      end

      it 'calls the NotifyViaSnailMail service' do
        expect(NotifyViaSnailMail)
          .to receive(:new)
          .with(order)
          .and_return(notification_service)
        expect(notification_service).to receive(:call)

        NotifyUserOfShipment.new(order).send_notification
      end
    end

    context 'when the user prefers a text' do
      let(:user) do
        instance_double(User, prefers_email?:      false,
                              prefers_snail_mail?: false,
                              prefers_text?:       true)
      end

      it 'calls the NotifyViaText service' do
        expect(NotifyViaText)
          .to receive(:new)
          .with(order)
          .and_return(notification_service)
        expect(notification_service).to receive(:call)

        NotifyUserOfShipment.new(order).send_notification
      end
    end
  end
end
