require 'rails_helper'

describe UserMailer, type: :mailer do
  let(:user) { FactoryGirl.create(:user) }
  let(:events) { 3.times.collect { FactoryGirl.create(:event, user: user) } }
  let(:mail) { described_class.notification_email(user, events) }

  subject { mail }

  its(:subject) { should eq('Your events for today!') }
  its(:to) { should eq([user.email]) }
  its(:from) { should eq(['from@example.com']) }
  its(:body) { should match(user.display_name) }
  its(:body) { should match(events.sample.title) }
end
