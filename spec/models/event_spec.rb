require 'rails_helper'

describe Event do
  let(:event) { FactoryGirl.create(:event) }

  subject { event }

  it { should be_valid }

  it { should respond_to(:user) }
  it { should respond_to(:ends_on) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:starts_on) }
  it { should enumerize(:repeats).in(*Event::REPEAT_TYPES) }

  describe '#repeats' do
    context 'recurring' do
      before { subject.update_attributes(recurring: true, ends_on: subject.starts_on.prev_day) }

      it { should validate_presence_of(:repeats) }
      its(:errors) { should include(:ends_on) }
    end

    context 'not recurring' do
      before { subject.recurring = false }
      it { should_not validate_presence_of(:repeats) }
      it { should_not validate_presence_of(:ends_on) }
    end
  end

  describe '#as_json' do
    let(:expected_result) do
      {
        id: event.id,
        title: event.title,
        start: event.starts_on,
        ends_on: event.ends_on
      }
    end

    its(:as_json) { should eq(expected_result) }
  end
end