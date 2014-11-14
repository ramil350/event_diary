require 'rails_helper'

describe 'Delete event' do
  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event) }

  before do
    login_as user
    visit edit_event_path(event)

    click_link 'Delete'
  end

  it 'should succeed' do
    expect(page).to have_css('.alert.alert-success', text: 'Event deleted successfully.')
  end
end