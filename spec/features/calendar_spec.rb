require 'rails_helper'

describe 'Calendar'  do
  let(:user) { FactoryGirl.create(:user) }
  let!(:event1) { FactoryGirl.create(:event, user: user) }
  let!(:event2) { FactoryGirl.create(:event, user: user) }
  let!(:event3) { FactoryGirl.create(:event, user: user) }

  before { login_as user }

  subject { page }

  context 'My events' do
    before { visit my_calendar_path }

    it { should have_link('New event', href: new_event_path(user)) }
    it { should have_css('.panel-heading', text: 'My events') }
  end

  context 'My events' do
    before { visit public_calendar_path }

    it { should have_css('.panel-heading', text: 'Public calendar') }
  end
end