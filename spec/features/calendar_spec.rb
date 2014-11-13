require 'rails_helper'

describe 'Calendar' do
  let(:user) { FactoryGirl.create(:user) }
  let!(:event1) { FactoryGirl.create(:event, user: user) }
  let!(:event2) { FactoryGirl.create(:event, user: user) }
  let!(:event3) { FactoryGirl.create(:event, user: user) }

  before do
    login_as user
    visit user_calendar_path(user)
  end

  subject { page }

  it { should have_link('New event', href: new_event_path(user)) }
  # it { should have_content(event1.title) }
end