require 'rails_helper'

describe MailingService do
  let(:day) { Date.today }

  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:users) { [user1, user2] }

  let!(:event1) { FactoryGirl.create(:event, starts_on: day, user: user1) }
  let!(:event2) { FactoryGirl.create(:event, :recurring, repeats: :daily, starts_on: day.yesterday, user: user2) }
  let!(:event3) { FactoryGirl.create(:event) }
  let(:service) { described_class.new(users, day) }

  describe '#notify' do
    it 'should notify users about events for today' do
      expect { service.notify }.to change { ActionMailer::Base.deliveries.count }.by(2)
    end
  end

  describe '#notification_for' do
    let(:events) { [event1] }
    let(:expected_email) { UserMailer.notification_email(user1, events) }

    it 'should generate the right mail' do
      expect(service.send(:notification_for, user1, events)).to eq(expected_email)
    end
  end
end