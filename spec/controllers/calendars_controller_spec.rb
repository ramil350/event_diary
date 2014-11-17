require 'rails_helper'

describe CalendarsController, type: :controller do

  context 'unauthenticated' do
    it_behaves_like 'action redirecting to sign in', :index
    it_behaves_like 'action redirecting to sign in', :user_calendar
  end

  context 'authenticated' do
    let(:user) { FactoryGirl.create(:user) }
    let!(:event1) { FactoryGirl.create(:event, user: user, starts_on: Date.today) }
    let!(:event2) { FactoryGirl.create(:event, starts_on: Date.today) }
    let!(:event3) { FactoryGirl.create(:event, user: user, starts_on: Date.tomorrow) }

    before { sign_in user }

    it_behaves_like 'calendar action', :index do
      let(:start_date) { Date.today }
      let(:end_date) { start_date }
      let(:expected_json) { [event1, event2].to_json }
    end

    it_behaves_like 'calendar action', :user_calendar do
      let(:start_date) { Date.today }
      let(:end_date) { start_date }
      let(:expected_json) { [event1].to_json }
    end
  end
end