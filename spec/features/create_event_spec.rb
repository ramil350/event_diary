require 'rails_helper'

describe 'Create event' do
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as user
    visit new_user_event_path(user)

    fill_in 'Title', with: new_event.title
    fill_in 'Starts on', with: new_event.starts_on
    check 'Recurring'
    select 'daily', from: 'Repeats'

    click_button 'Create event'
  end

  context 'with valid values' do
    let(:new_event) { FactoryGirl.build(:event, user: user) }

    it 'should succeed' do
      expect(page).to have_css('.alert.alert-success', text: 'Event created successfully.')
    end

    it 'should create event' do
      expect(Event.count).to eq(1)
    end
  end

  context 'with invalid values' do
    let(:new_event) { FactoryGirl.build(:event, user: user, title: nil) }

    it 'should show errors' do
      expect(page).to have_css('.alert.alert-danger')
    end
  end
end