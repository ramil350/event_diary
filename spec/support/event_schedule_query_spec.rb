require 'rails_helper'

describe EventScheduleQuery do
  let(:query) { described_class.new(Event.all) }

  describe '#build' do
    let(:month_start) { Date.today.beginning_of_month }
    let(:month_end) { month_start.end_of_month }

    let!(:event1) { FactoryGirl.create(:event, :recurring, repeats: :monthly, starts_on: month_start.prev_month) }
    let!(:event2) { FactoryGirl.create(:event, :recurring, repeats: :daily, starts_on: month_end.prev_day) }
    let!(:event3) { FactoryGirl.create(:event, starts_on: month_start) }
    let!(:event4) { FactoryGirl.create(:event, starts_on: month_end.next_month )}

    let(:expected_result) { [event1, event3, event2, event2] }

    subject { query.build(month_start, month_end) }

    it { should eq(expected_result) }
  end
end