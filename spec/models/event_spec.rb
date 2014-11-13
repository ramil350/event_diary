require 'rails_helper'

describe Event do
  let(:event) { FactoryGirl.create(:event) }

  subject { event }

  it { should be_valid }

  it { should respond_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:starts_on) }
  it { should enumerize(:repeats).in(*Event::REPEAT_TYPES) }

  describe 'repeats' do
    context 'recurring' do
      before { subject.recurring = true }
      it { should validate_presence_of(:repeats) }
    end

    context 'not recurring' do
      before { subject.recurring = false }
      it { should_not validate_presence_of(:repeats) }
    end
  end

  describe '#as_json' do
    let(:expected_result) do
      {
        id: event.id,
        title: event.title,
        start: event.starts_on
      }
    end

    its(:as_json) { should eq(expected_result) }
  end

  describe 'scopes' do
    context '.for_user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:event1) { FactoryGirl.create(:event) }
      let(:event2) { FactoryGirl.create(:event, user: user) }

      subject { described_class.for_user(user) }

      it { should eq([event2]) }
    end

    context '.over_period' do
      let(:starts_on) { Date.today.beginning_of_month }
      let(:ends_on) { starts_on.end_of_month }
      let(:event1) { FactoryGirl.create(:event, starts_on: ends_on.prev_day) }
      let(:event2) { FactoryGirl.create(:event, starts_on: ends_on.next_year) }
      let(:event3) { FactoryGirl.create(:event, starts_on: starts_on.next_day) }

      subject { described_class.over_period(starts_on, ends_on) }

      it { should eq([event3, event1]) }
    end
  end
end