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
  end
end