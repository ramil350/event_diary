require 'rails_helper'

describe 'Edit event' do
  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event) }

  before do
    login_as user
    visit edit_event_path(event)

    fill_in 'Title', with: 'New title'
    fill_in 'Starts on', with: Date.tomorrow
    click_button 'Submit'
  end

  context 'with valid values' do
    it 'should succeed' do
      expect(page).to have_css('.alert.alert-success', text: 'Event updated successfully.')
    end
  end

  # context 'with invalid values' do
  #   let(:new_event) { FactoryGirl.build(:event, user: user, title: nil) }
  #
  #   it 'should show errors' do
  #     expect(page).to have_css('.alert.alert-danger')
  #   end
  # end
end